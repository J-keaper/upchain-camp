require("@nomicfoundation/hardhat-toolbox");
require("hardhat-abi-exporter");
let dotenv = require("dotenv");
dotenv.config();

const mnemonic = process.env.MNEMONIC;

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.18",
  networks: {
    dev: {
      url: "http://127.0.0.1:8545/",
      chainId: 31337,
      gas: 12000000,
    },
    mumbai: {
      url: "https://polygon-mumbai.g.alchemy.com/v2/-OLOlMPIbfrgxDQxKeeCTqTKGnQq-Np7",
      chainId: 80001,
      accounts: {
        mnemonic: mnemonic, // 0xBB8E6cBF36DA79A01772DA50f94607eFC8D841ae
      },
    },
    goerli: {
      url: "https://eth-goerli.g.alchemy.com/v2/8cQJa6DD4QC3y6w0Frr5F2I4LJx8BqO0",
      chainId: 5,
      accounts: {
        mnemonic: mnemonic, // 0xBB8E6cBF36DA79A01772DA50f94607eFC8D841ae
      },
    },
  },
  abiExporter: {
    path: "./deployments/abi",
    clear: true,
    flat: true,
    only: [],
    spacing: 2,
    pretty: false,
  },

  etherscan: {
    apiKey: {
      polygonMumbai: process.env.POLYGONSCAN_KEY,
      goerli: process.env.ETHERSCAN_KEY,
    },
  },
};
