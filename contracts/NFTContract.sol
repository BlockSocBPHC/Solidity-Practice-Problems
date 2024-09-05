// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract NFTContract is ERC721 {

    uint256 private _tokenIds = 0;
    uint256 public PRICE_PER_TOKEN = 0.01 ether;

    constructor() ERC721("NFTContract", "NFT")
    {}

    function mintNFT( address owner )
        payable
        external
        returns (uint256)
    {
        require(PRICE_PER_TOKEN <= msg.value, "Ether paid is incorrect");
        uint256 newItemId = _tokenIds;
        _safeMint(owner, newItemId);

        _tokenIds++;
        return newItemId;
    }
}
