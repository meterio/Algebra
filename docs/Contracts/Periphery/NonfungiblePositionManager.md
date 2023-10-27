

# NonfungiblePositionManager


NFT positions

Wraps Algebra  positions in the ERC721 non-fungible token interface

*Developer note: Credit to Uniswap Labs under GPL-2.0-or-later license:
https://github.com/Uniswap/v3-periphery*

## Modifiers
### isAuthorizedForToken


`modifier isAuthorizedForToken(uint256 tokenId)`  internal





| Name | Type | Description |
| ---- | ---- | ----------- |
| tokenId | uint256 |  |




## Variables
### address farmingCenter 



*Developer note: The address of the farming center contract, which handles farmings logic*
### mapping(uint256 &#x3D;&gt; address) farmingApprovals 



*Developer note: mapping tokenId &#x3D;&gt; farmingCenter*
### mapping(uint256 &#x3D;&gt; address) tokenFarmedIn 



*Developer note: mapping tokenId &#x3D;&gt; farmingCenter*
### bytes32 NONFUNGIBLE_POSITION_MANAGER_ADMINISTRATOR_ROLE constant




## Functions
### constructor


`constructor(address _factory, address _WNativeToken, address _tokenDescriptor_, address _poolDeployer) public`  public





| Name | Type | Description |
| ---- | ---- | ----------- |
| _factory | address |  |
| _WNativeToken | address |  |
| _tokenDescriptor_ | address |  |
| _poolDeployer | address |  |


### positions


`function positions(uint256 tokenId) external view returns (uint88 nonce, address operator, address token0, address token1, int24 tickLower, int24 tickUpper, uint128 liquidity, uint256 feeGrowthInside0LastX128, uint256 feeGrowthInside1LastX128, uint128 tokensOwed0, uint128 tokensOwed1)` view external

Returns the position information associated with a given token ID.
*Developer note: Throws if the token ID is not valid.*



| Name | Type | Description |
| ---- | ---- | ----------- |
| tokenId | uint256 | The ID of the token that represents the position |

**Returns:**

| Name | Type | Description |
| ---- | ---- | ----------- |
| nonce | uint88 | The nonce for permits |
| operator | address | The address that is approved for spending |
| token0 | address | The address of the token0 for a specific pool |
| token1 | address | The address of the token1 for a specific pool |
| tickLower | int24 | The lower end of the tick range for the position |
| tickUpper | int24 | The higher end of the tick range for the position |
| liquidity | uint128 | The liquidity of the position |
| feeGrowthInside0LastX128 | uint256 | The fee growth of token0 as of the last action on the individual position |
| feeGrowthInside1LastX128 | uint256 | The fee growth of token1 as of the last action on the individual position |
| tokensOwed0 | uint128 | The uncollected amount of token0 owed to the position as of the last computation |
| tokensOwed1 | uint128 | The uncollected amount of token1 owed to the position as of the last computation |

### mint


`function mint(struct INonfungiblePositionManager.MintParams params) external payable returns (uint256 tokenId, uint128 liquidity, uint256 amount0, uint256 amount1)` payable external

Creates a new position wrapped in a NFT
*Developer note: Call this when the pool does exist and is initialized. Note that if the pool is created but not initialized
a method does not exist, i.e. the pool is assumed to be initialized.*



| Name | Type | Description |
| ---- | ---- | ----------- |
| params | struct INonfungiblePositionManager.MintParams | The params necessary to mint a position, encoded as &#x60;MintParams&#x60; in calldata |

**Returns:**

| Name | Type | Description |
| ---- | ---- | ----------- |
| tokenId | uint256 | The ID of the token that represents the minted position |
| liquidity | uint128 | The amount of liquidity for this position |
| amount0 | uint256 | The amount of token0 |
| amount1 | uint256 | The amount of token1 |

### tokenURI


`function tokenURI(uint256 tokenId) public view returns (string)` view public





| Name | Type | Description |
| ---- | ---- | ----------- |
| tokenId | uint256 |  |

**Returns:**

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | string |  |

### baseURI


`function baseURI() public pure returns (string)` pure public






**Returns:**

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | string |  |

### increaseLiquidity


`function increaseLiquidity(struct INonfungiblePositionManager.IncreaseLiquidityParams params) external payable returns (uint128 liquidity, uint256 amount0, uint256 amount1)` payable external

Increases the amount of liquidity in a position, with tokens paid by the &#x60;msg.sender&#x60;



| Name | Type | Description |
| ---- | ---- | ----------- |
| params | struct INonfungiblePositionManager.IncreaseLiquidityParams | tokenId The ID of the token for which liquidity is being increased, amount0Desired The desired amount of token0 to be spent, amount1Desired The desired amount of token1 to be spent, amount0Min The minimum amount of token0 to spend, which serves as a slippage check, amount1Min The minimum amount of token1 to spend, which serves as a slippage check, deadline The time by which the transaction must be included to effect the change |

**Returns:**

| Name | Type | Description |
| ---- | ---- | ----------- |
| liquidity | uint128 | The new liquidity amount as a result of the increase |
| amount0 | uint256 | The amount of token0 to achieve resulting liquidity |
| amount1 | uint256 | The amount of token1 to achieve resulting liquidity |

### decreaseLiquidity


`function decreaseLiquidity(struct INonfungiblePositionManager.DecreaseLiquidityParams params) external payable returns (uint256 amount0, uint256 amount1)` payable external

Decreases the amount of liquidity in a position and accounts it to the position



| Name | Type | Description |
| ---- | ---- | ----------- |
| params | struct INonfungiblePositionManager.DecreaseLiquidityParams | tokenId The ID of the token for which liquidity is being decreased, amount The amount by which liquidity will be decreased, amount0Min The minimum amount of token0 that should be accounted for the burned liquidity, amount1Min The minimum amount of token1 that should be accounted for the burned liquidity, deadline The time by which the transaction must be included to effect the change |

**Returns:**

| Name | Type | Description |
| ---- | ---- | ----------- |
| amount0 | uint256 | The amount of token0 accounted to the position&#x27;s tokens owed |
| amount1 | uint256 | The amount of token1 accounted to the position&#x27;s tokens owed |

### collect


`function collect(struct INonfungiblePositionManager.CollectParams params) external payable returns (uint256 amount0, uint256 amount1)` payable external

Collects up to a maximum amount of fees owed to a specific position to the recipient



| Name | Type | Description |
| ---- | ---- | ----------- |
| params | struct INonfungiblePositionManager.CollectParams | tokenId The ID of the NFT for which tokens are being collected, recipient The account that should receive the tokens, amount0Max The maximum amount of token0 to collect, amount1Max The maximum amount of token1 to collect |

**Returns:**

| Name | Type | Description |
| ---- | ---- | ----------- |
| amount0 | uint256 | The amount of fees collected in token0 |
| amount1 | uint256 | The amount of fees collected in token1 |

### burn


`function burn(uint256 tokenId) external payable` payable external

Burns a token ID, which deletes it from the NFT contract. The token must have 0 liquidity and all tokens
must be collected first.



| Name | Type | Description |
| ---- | ---- | ----------- |
| tokenId | uint256 | The ID of the token that is being burned |


### approveForFarming


`function approveForFarming(uint256 tokenId, bool approve) external payable` payable external

Changes approval of token ID for farming.



| Name | Type | Description |
| ---- | ---- | ----------- |
| tokenId | uint256 | The ID of the token that is being approved / unapproved |
| approve | bool | New status of approval |


### switchFarmingStatus


`function switchFarmingStatus(uint256 tokenId, bool toFarming) external`  external

Changes farming status of token to &#x27;farmed&#x27; or &#x27;not farmed&#x27;
*Developer note: can be called only by farmingCenter*



| Name | Type | Description |
| ---- | ---- | ----------- |
| tokenId | uint256 | tokenId The ID of the token |
| toFarming | bool |  |


### setFarmingCenter


`function setFarmingCenter(address newFarmingCenter) external`  external

Changes address of farmingCenter
*Developer note: can be called only by factory owner or NONFUNGIBLE_POSITION_MANAGER_ADMINISTRATOR_ROLE*



| Name | Type | Description |
| ---- | ---- | ----------- |
| newFarmingCenter | address | The new address of farmingCenter |


### getApproved


`function getApproved(uint256 tokenId) public view returns (address)` view public


*Developer note: Returns the account approved for &#x60;tokenId&#x60; token.

Requirements:

- &#x60;tokenId&#x60; must exist.*



| Name | Type | Description |
| ---- | ---- | ----------- |
| tokenId | uint256 |  |

**Returns:**

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | address |  |




