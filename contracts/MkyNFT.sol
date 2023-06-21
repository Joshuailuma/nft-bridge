// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract MkyNFT is ERC721URIStorage {
    // URL for the prompt description
    string public myPromptURL =
        "https://gateway.pinata.cloud/ipfs/Qmb1H2StQJGwo1aFuPWpjbAyZGQYNG3hk2TukVYdTivrAS";

    uint256 private s_tokenCounter;

    // Owner of the contract
    address public owner;
    // Total supply of the tokens
    uint256 public totalSupply;

    // Mapping tokenId to tokenUri
    // Every tokenId should have a unique uri
    mapping(uint => string) private tokenIdToUri;

    constructor() ERC721("MkyNFT", "MKY") {
        totalSupply = 0;
    }

    /*
     * @notice Method to mint an NFT
     * @param tokenUri of the property to store
     */
    function mintNft(string memory tokenUri) public {
        require(msg.sender == owner, "Only owner can mint new tokens");
        // Check if totalSupply is less or equal 5
        require(totalSupply <= 5, "Total supply cannot exceed 5");

        s_tokenCounter += 1; // Increase the counter
        tokenIdToUri[s_tokenCounter] = tokenUri;
        _safeMint(msg.sender, s_tokenCounter); //To mint the nft

        _setTokenURI(s_tokenCounter, tokenUri); // Sets the token uri
    }

    /*
     * @notice Method to get the tokenCounter Number of the property
     */
    function getTokenCounter() public view returns (uint256) {
        return s_tokenCounter;
    }

    /*
     * @notice Method to get the tokenUri of a particular property
     * @param tokenId Token ID of the property
     */
    function getTokenUri(uint256 tokenId) public view returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: Token ID is does not exist");
        return tokenIdToUri[tokenId];
    }

    /**
     * Get the promt description url
     */
    function promptDescription() public view returns (string memory) {
        return myPromptURL;
    }
}
