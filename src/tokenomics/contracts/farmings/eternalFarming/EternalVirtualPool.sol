// SPDX-License-Identifier: BUSL-1.1
pragma solidity =0.7.6;

import 'algebra/contracts/libraries/TickManager.sol';
import 'algebra/contracts/libraries/TickTable.sol';

import 'algebra/contracts/libraries/FullMath.sol';
import 'algebra/contracts/libraries/Constants.sol';

import './interfaces/IAlgebraEternalVirtualPool.sol';

import '../AlgebraVirtualPoolBase.sol';

contract EternalVirtualPool is AlgebraVirtualPoolBase, IAlgebraEternalVirtualPool {
    using TickTable for mapping(int16 => uint256);
    using TickManager for mapping(int24 => TickManager.Tick);

    uint128 public rewardRate0;
    uint128 public rewardRate1;

    uint256 public rewardReserve0;
    uint256 public rewardReserve1;

    uint256 public totalRewardGrowth0;
    uint256 public totalRewardGrowth1;

    constructor(
        address _farmingCenterAddress,
        address _farmingAddress,
        address _pool
    ) AlgebraVirtualPoolBase(_farmingCenterAddress, _farmingAddress, _pool) {
        prevTimestamp = uint32(block.timestamp);
    }

    function addRewards(uint256 token0Amount, uint256 token1Amount) external override onlyFarming {
        _increaseCumulative(uint32(block.timestamp));
        if (token0Amount > 0) rewardReserve0 += token0Amount;
        if (token1Amount > 0) rewardReserve1 += token1Amount;
    }

    function setRates(uint128 rate0, uint128 rate1) external override onlyFarming {
        _increaseCumulative(uint32(block.timestamp));
        (rewardRate0, rewardRate1) = (rate0, rate1);
    }

    // @inheritdoc IAlgebraEternalVirtualPool
    function getInnerSecondsPerLiquidity(int24 bottomTick, int24 topTick)
        external
        view
        override
        returns (uint160 innerSecondsSpentPerLiquidity)
    {
        return _getInnerSecondsPerLiquidity(bottomTick, topTick);
    }

    // @inheritdoc IAlgebraEternalVirtualPool
    function getInnerRewardsGrowth(int24 bottomTick, int24 topTick)
        external
        view
        override
        returns (uint256 rewardGrowthInside0, uint256 rewardGrowthInside1)
    {
        return ticks.getInnerFeeGrowth(bottomTick, topTick, globalTick, totalRewardGrowth0, totalRewardGrowth1);
    }

    function _crossTick(int24 nextTick) internal override returns (int128 liquidityDelta) {
        return ticks.cross(nextTick, totalRewardGrowth0, totalRewardGrowth1, globalSecondsPerLiquidityCumulative, 0, 0);
    }

    function _increaseCumulative(uint32 currentTimestamp) internal override returns (Status) {
        uint256 timeDelta = currentTimestamp - prevTimestamp; // safe until 2053 year
        if (!(timeDelta < currentTimestamp)) return Status.ACTIVE; // only once per block

        uint256 _currentLiquidity = currentLiquidity; // currentLiquidity is uint128
        if (_currentLiquidity > 0) {
            (uint256 _rewardRate0, uint256 _rewardRate1) = (rewardRate0, rewardRate1);
            uint256 _rewardReserve0 = _rewardRate0 > 0 ? rewardReserve0 : 0;
            uint256 _rewardReserve1 = _rewardRate1 > 0 ? rewardReserve1 : 0;

            if (_rewardReserve0 > 0) {
                uint256 reward0 = _rewardRate0 * timeDelta;
                if (reward0 > _rewardReserve0) reward0 = _rewardReserve0;
                rewardReserve0 = _rewardReserve0 - reward0;
                totalRewardGrowth0 += FullMath.mulDiv(reward0, Constants.Q128, _currentLiquidity);
            }

            if (_rewardReserve1 > 0) {
                uint256 reward1 = _rewardRate1 * timeDelta;
                if (reward1 > _rewardReserve1) reward1 = _rewardReserve1;
                rewardReserve1 = _rewardReserve1 - reward1;
                totalRewardGrowth1 += FullMath.mulDiv(reward1, Constants.Q128, _currentLiquidity);
            }
            globalSecondsPerLiquidityCumulative += (uint160(timeDelta) << 128) / uint160(_currentLiquidity);
            prevTimestamp = currentTimestamp; // duplicated for gas optimization
        } else {
            timeOutside += uint32(timeDelta);
            prevTimestamp = currentTimestamp; // duplicated for gas optimization
        }

        return Status.ACTIVE;
    }

    function _updateTick(
        int24 tick,
        int24 currentTick,
        int128 liquidityDelta,
        bool isTopTick
    ) internal override returns (bool updated) {
        return
            ticks.update(tick, currentTick, liquidityDelta, totalRewardGrowth0, totalRewardGrowth1, 0, 0, 0, isTopTick);
    }
}
