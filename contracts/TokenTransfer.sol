// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract SimpleToken {
    mapping(address => uint256) public balances;
    //associates address with the token balances , allows the users to look up the balance in their own address
    address public owner;   

    constructor() {
        owner = msg.sender;
    }

    function mint(address to, uint256 amount) public {
        require(msg.sender == owner, "Only the owner can mint tokens");
        balances[to] += amount;
    }

    function transfer(address to, uint256 amount) public {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        balances[to] += amount;
    }
}
