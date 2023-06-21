require("@nomicfoundation/hardhat-toolbox");
require("hardhat-deploy")
require("dotenv").config({ path: ".env" });
require("@nomicfoundation/hardhat-foundry");

/** @type import('hardhat/config').HardhatUserConfig */

const RPC_URL = process.env.GOERLI_URL;
const PRIVATE_KEY = process.env.PRIVATE_KEY;
const ETHERSCAN_API_KEY = process.env.ETHERSCAN_API_KEY

module.exports = {
  solidity: "0.8.18",
  networks: {
    goerli: {
      url: RPC_URL,
      chainId: 5,
      accounts: [PRIVATE_KEY],
      blockConfirmations: 5,
    },
    hardhat: {
      chainId: 31337,
    },

    localhost: {
      chainId: 31337,
    },
  },

  namedAccounts: {
    deployer: {
      default: 0,
    }
  },
  etherscan: {
    apiKey: ETHERSCAN_API_KEY,
  },
};
