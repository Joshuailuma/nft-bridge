const { run, ethers, network } = require("hardhat");
require("hardhat-deploy")
require("dotenv").config({ path: ".env" });

async function main() {
  const { deployer } = await getNamedAccounts()
  // Deploy TransferEth Contract
  const mkyNFT = await ethers.getContractFactory("MkyNFTB", deployer);
  const deployedMkyNFT = await mkyNFT.deploy();
  await deployedMkyNFT.deployed();

  console.log('Deployed MKYNFT Contract to ');
  console.log(deployedMkyNFT.address);

  // Wait for block confirmations. We shall wait for 60 seconds
  setTimeout(verify(), 60000)

  // Verify the contract on etherscan
  async function verify() {
    try {
      await run("verify:verify", {
        network: 'goerli',
        address: deployedMkyNFT.address,
        constructorArguments: [],
      });
      console.log("Etherscan verification done. ✅");

    } catch (error) {
      console.error(error);
    }
  }

}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

//npx hardhat verify --network mainnet DEPLOYED_CONTRACT_ADDRESS "Constructor argument 1"
