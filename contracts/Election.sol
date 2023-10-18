// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Election {
    uint256 public candidate1;
    uint256 public candidate2;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function voteForCandidate1() public {
        require(msg.sender != owner, "Owner cannot vote");
        candidate1++;
    }

    function voteForCandidate2() public {
        require(msg.sender != owner, "Owner cannot vote");
        candidate2++;
    }
}
