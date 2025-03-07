

# IAlgebraPoolDeployer


An interface for a contract that is capable of deploying Algebra Pools

A contract that constructs a pool must implement this to pass arguments to the pool

*Developer note: This is used to avoid having constructor arguments in the pool contract, which results in the init code hash
of the pool being constant allowing the CREATE2 address of the pool to be cheaply computed on-chain.
Credit to Uniswap Labs under GPL-2.0-or-later license:
https://github.com/Uniswap/v3-core/tree/main/contracts/interfaces*




## Functions
### getDeployParameters


`function getDeployParameters() external view returns (address dataStorage, address factory, address communityVault, address token0, address token1)` view external

Get the parameters to be used in constructing the pool, set transiently during pool creation.
*Developer note: Called by the pool constructor to fetch the parameters of the pool*




**Returns:**

| Name | Type | Description |
| ---- | ---- | ----------- |
| dataStorage | address | The pools associated dataStorage |
| factory | address | The factory address |
| communityVault | address | The community vault address |
| token0 | address | The first token of the pool by address sort order |
| token1 | address | The second token of the pool by address sort order |

### deploy


`function deploy(address dataStorage, address token0, address token1) external returns (address pool)`  external


*Developer note: Deploys a pool with the given parameters by transiently setting the parameters in cache.*



| Name | Type | Description |
| ---- | ---- | ----------- |
| dataStorage | address | The pools associated dataStorage |
| token0 | address | The first token of the pool by address sort order |
| token1 | address | The second token of the pool by address sort order |

**Returns:**

| Name | Type | Description |
| ---- | ---- | ----------- |
| pool | address | The deployed pool&#x27;s address |




