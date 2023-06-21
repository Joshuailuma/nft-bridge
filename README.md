# NFT Bridge

This project demonstrates how to bridge or move an NFT from Goerli to the Polygon network. A combination of Hardhat and Foundry was used to set up the project.

## Description
- The contracts folder contains two solidity files. The `MKYNFT.sol` is an ERC721 contract that facilitates the creation of an NFT.

- The name of the NFT is `MkyNFT` and its symbol `MKY`. This is found in the constrctor `constructor() ERC721A("MkyNFT", "MKY")`

- The `MKYNFTBatch.sol` contains an ERC721A contract that allows for batch minting of NFTs while saving cost. 

- The number of NFTs to be minted has been restricted to only 5 ``uint8 public MAX_MINTS = 5;``

- The `promptUrl` contains the prompt given to DALLE-E to create images to be used for the NFTs

- The `baseUrl` is the url to be used for the NFTs. The first NFT minted during batch-mint will have a url of `baseUrl/0`, the second will have a url of `baseUrl/1` etc.

- `mint(uint256 quantity)` batch mints the nfts according to the quantity required.

- The images used for the NFTs have been stored on pinata.cloud
- The metadata have the follwing fields
    - name
    - description
    - image.
    
    The image urls have also been stored on pinata.cloud

- The scripts folder contains scripts to deploy the contract and to batch mint the NFTs

## Tasks

Run the following tasks:
- ``npm i`` To install the dependencies
- ``npx hardhat run scripts/deploy.js`` To deploy the ERC721 contract
- ``npx hardhat run scripts/deploy-batch.js`` To deploy the ERC721A contract
- ``npx hardhat run scripts/deploy-batch.js`` To batch-mint 5 nfts

### Bridging the NFT

In your Unix or Linux environment 

- Initialize git by running `git init`

- `forge --version` To check the version of forge installed. Install forge from https://book.getfoundry.sh/getting-started/installation

- `npx hardhat init-foundry` to initialize foundry in the hardhat project

- `forge build` to build the project, equivalent to `npx hardhat compile` 

- `export GTOKEN_ADDRS=0x743AeC8E865a7CB2A83BF379e5Bc97a14DB562B2` Save your deployed token address to the env

- `export MTOKEN_ADDRS=0x910fC1283e912f454b6Fd35a8832fE9Fa41B139a` Save your mapped token address to the env. Map your token here[https://mapper.polygon.technology/map] and save its child address as MTOKEN_ADDRS 

- `export FX_ADDRS=0x823eF03B39C339337E451d82cEC57f31316de15F` The address of the FxERC721RootTunnel Contract

- `[ ! -f .env ] || export $(grep -v '^#' .env | xargs)` To save all variables in env terminal

- `cast send $GTOKEN_ADDRS "approve(address, uint256)" \ $FX_ADDRS 0 \ --rpc-url $GOERLI_URL \ --private-key $PRIVATE_KEY` Manually approve FxERC721RootTunnel Contract to transfer each NFTs/token ids 0 to 4. Call the function repeatedly replacing the tokenId from 0 - 4

- `cast send $FX_ADDRS "deposit(address,address,uint256, bytes)" $GTOKEN_ADDRS $M_ADDRS 0 0x00 --rpc-url $GOERLI_URL --private-key $PRIVATE_KEY` Deposit each NFTs to the bridge. Call the function repeatedly replacing the tokenId from 0 - 4

- wait for 20 to 25 minutes for the state sync to happen

- `cast call $MTOKEN_ADDRS "balanceOf(address)(uint256)" $M_ADDRS \ --rpc-url $MUMBAI_URL` Check to see if your new address on Mumbai has received the tokens

## Author
Joshua Iluma
