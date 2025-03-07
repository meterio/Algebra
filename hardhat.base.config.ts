const path = require('path')
const config = require('dotenv').config({ path: path.resolve(__dirname, '.env') })
const {
  ETHERSCAN_API_KEY,
  BSCSCAN_API_KEY,
  POLYGONSCAN_API_KEY,
  MNEMONIC,
  DEPLOY_GAS_LIMIT_MAX,
  DEPLOY_GAS_PRICE,
  INFURA_ID_PROJECT,
  METER_PRIVATE_KEY,
} = config.parsed || {}

export default {
  networks: {
    hardhat: {
      allowUnlimitedContractSize: true,
      loggingEnabled: false,
    },
    hhnode: {
      url: `http://127.0.0.1:7545`,
      accounts: [`0xa4e159c7ee60ba1f0ce8b4d3c7ae4f2978da06d69838f14d465dae7dde45bc2c`],
      allowUnlimitedContractSize: true,
      //gasPrice: 8,
      gas: 10000000,
      loggingEnabled: false,
    },
    mainnet: {
      url: `https://mainnet.infura.io/v3/${INFURA_ID_PROJECT}`,
    },
    ropsten: {
      url: `https://ropsten.infura.io/v3/${INFURA_ID_PROJECT}`,
      chainId: 3,
      accounts: [`0x${MNEMONIC || '1000000000000000000000000000000000000000000000000000000000000000'}`],
    },
    rinkeby: {
      url: `https://rinkeby.infura.io/v3/${INFURA_ID_PROJECT}`,
    },
    goerli: {
      url: `https://goerli.infura.io/v3/${INFURA_ID_PROJECT}`,
    },
    kovan: {
      url: `https://kovan.infura.io/v3/${INFURA_ID_PROJECT}`,
      chainId: 42,
      accounts: [`0x${MNEMONIC || '1000000000000000000000000000000000000000000000000000000000000000'}`],
      gasPrice: 8000000000,
    },
    bscTestnet: {
      url: `https://data-seed-prebsc-2-s3.binance.org:8545`,
      chainId: 97,
      accounts: [`0x${MNEMONIC || '1000000000000000000000000000000000000000000000000000000000000000'}`],
    },
    bsc: {
      url: `https://bsc-dataseed3.binance.org`,
    },
    maticTestnet: {
      url: `https://rpc-mumbai.maticvigil.com`,
      chainId: 80001,
      accounts: [`0x${MNEMONIC || '1000000000000000000000000000000000000000000000000000000000000000'}`],
    },
    maticMainnet: {
      url: `https://rpc-mainnet.matic.quiknode.pro`,
      chainId: 137,
      accounts: [`0x${MNEMONIC || '1000000000000000000000000000000000000000000000000000000000000000'}`],
      gasPrice: 50_000_000_000,
    },
    metertest: {
      url: `https://rpctest.meter.io`,
      chainId: 83,
      accounts: [METER_PRIVATE_KEY],
      gasPrice: 50_000_000_000,
    },
  },
  etherscan: {
    // Your API key for Etherscan
    // Obtain one at https://etherscan.io/
    apiKey: `${POLYGONSCAN_API_KEY}`,
  },
}
