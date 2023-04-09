require("@nomicfoundation/hardhat-toolbox");

let dotenv = require("dotenv");
dotenv.config();

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.18",
  networks: {
    mumbai: {
      url: "https://polygon-mumbai.g.alchemy.com/v2/-OLOlMPIbfrgxDQxKeeCTqTKGnQq-Np7",
      chainId: 80001,
      accounts: [process.env.ACCOUNT_KEY],
    },
    goerli: {
      url: "https://eth-goerli.g.alchemy.com/v2/8cQJa6DD4QC3y6w0Frr5F2I4LJx8BqO0",
      chainId: 5,
      accounts: [process.env.ACCOUNT_KEY],
    },
  },

  etherscan: {
    apiKey: {
      polygonMumbai: process.env.POLYGONSCAN_KEY,
      goerli: process.env.ETHERSCAN_KEY,
    },
  },
};
