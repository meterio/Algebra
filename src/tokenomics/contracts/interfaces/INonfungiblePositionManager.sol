// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.7.5;
pragma abicoder v2;

interface INonfungiblePositionManager {
  /// @notice Changes address of farmingCenter
  /// @dev can be called only by factory owner or NONFUNGIBLE_POSITION_MANAGER_ADMINISTRATOR_ROLE
  /// @param newFarmingCenter The new address of farmingCenter
  function setFarmingCenter(address newFarmingCenter) external;
}
