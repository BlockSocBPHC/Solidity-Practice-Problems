// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract NFTContract is ERC721 {

    uint256 private _tokenIds = 0;
    uint256 private _totalMinted = 0;

    string[]  private tokenURIs;
    uint256 public PRICE_PER_TOKEN = 0.01 ether;

    uint256 public LIMIT_PER_ADDRESS = 5;
    uint256 public MAX_SUPPLY  = 5;

    constructor() ERC721("NFTContract", "NFT")
    {}

    function mintNFT( address owner )
        payable
        external
        returns (uint256)
    {
        uint256 newItemId = _tokenIds;
        _safeMint(owner, newItemId);

        _tokenIds++;
        _totalMinted++;
        return newItemId;
    }
}
