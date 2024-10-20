// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// This contract allows only the owner to withdraw funds,
// while anyone can deposit Ether.
contract AccessControl {
    address public owner;

    // Events help to track actions performed on the contract.
    event FundsDeposited(address indexed sender, uint amount);
    event FundsWithdrawn(address indexed owner, uint amount);

    // The constructor is executed when the contract is deployed.
    // It sets the deployer as the owner of the contract.
    constructor() {
        owner = msg.sender; // Set the person deploying the contract as the owner
    }

    // Modifier to restrict function access to only the contract owner.
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function!");
        _;
    }

    // This function allows anyone to deposit Ether into the contract.
    // Payable means the function can accept Ether.
    function deposit() external payable {
        require(msg.value > 0, "You need to send some Ether");
        emit FundsDeposited(msg.sender, msg.value);
    }

    // This function allows only the owner to withdraw the entire contract balance.
    // It uses the `onlyOwner` modifier to ensure that only the owner can execute it.
    function withdraw() external onlyOwner {
        uint balance = address(this).balance;
        require(balance > 0, "No funds to withdraw");

        // Transfer the entire balance to the owner.
        (bool success, ) = owner.call{value: balance}("");
        require(success, "Failed to withdraw funds");

        emit FundsWithdrawn(owner, balance);
    }

    // View function to check the contract balance (in Wei).
    function getBalance() external view returns (uint) {
        return address(this).balance;
    }
}
