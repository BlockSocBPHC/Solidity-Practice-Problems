// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract CoinFlip {
    address public player;
    uint256 public betAmount;
    uint256 public seed;

    constructor() {
        player = msg.sender;
    }

    function flipCoin() public payable {
        require(msg.value > 0, "Bet amount must be greater than 0");
        require(msg.sender == player, "Only the player can call this function");

        seed = uint256(keccak256(abi.encodePacked(block.timestamp, block.prevrandao, msg.sender))) % 2;
        // generating a pseudo random seed based on the factors
        // block.difficulty ==> measure of how hard it is to mine a block , it adds unpredictability

        if (seed == 0) {
            payable(player).transfer(address(this).balance);
        }
    }
}
