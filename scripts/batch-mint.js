const { ethers, network } = require("hardhat")
require("dotenv").config({ path: ".env" });

async function mintBatchNft() {
    const { deployer } = await getNamedAccounts()

    // Already deployed ERC721A contract address
    const address = "0x743AeC8E865a7CB2A83BF379e5Bc97a14DB562B2"
    const mykNFT = await ethers.getContractFactory("MkyNFTB", deployer);

    const mykNFTContract = mykNFT.attach(address); // Connect to the deployed contract
    // Mint 5 NFTs
    await mykNFTContract.mint(5)

    console.log("=====Minted 5 NFTs======");
}

mintBatchNft()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error)
        process.exit(1)
    })