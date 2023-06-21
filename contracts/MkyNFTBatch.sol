// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

import "erc721a/contracts/ERC721A.sol";

contract MkyNFTB is ERC721A {
    address public owner;

    uint8 public MAX_MINTS = 5;
    // Total supply of the tokens

    // Base url for the nfts
    string baseUrl =
        "https://gateway.pinata.cloud/ipfs/QmWXZwNDtDt9hSocCamPw5YcRHnYX3CZYQLHfzYpYCaXgq/";

    // The URL for the prompt description
    string public myPromptURL =
        "https://gateway.pinata.cloud/ipfs/Qmb1H2StQJGwo1aFuPWpjbAyZGQYNG3hk2TukVYdTivrAS";

    constructor() ERC721A("MkyNFT", "MKY") {
        owner = msg.sender;
    }

    // Modifier that only allows the owner to execute a function
    modifier onlyOwner() {
        require(msg.sender == owner, "You are not an owner");
        _;
    }

    // Function to mint NFT which only owner can perform
    function mint(uint256 quantity) external payable onlyOwner {
        //E.G 0 + 5
        require(
            totalSupply() + quantity <= MAX_MINTS,
            "You can not mint more than 5"
        );
        require(
            quantity + _numberMinted(msg.sender) <= MAX_MINTS,
            "You can not mint more than 5 per perrson"
        );
        _mint(msg.sender, quantity);
    }

    // Override the baseURI function to return the base URL for the NFTs
    function _baseURI() internal view override returns (string memory) {
        return baseUrl;
    }

    // Return the URL for the prompt description
    function promptDescription() external view returns (string memory) {
        return myPromptURL;
    }
}
