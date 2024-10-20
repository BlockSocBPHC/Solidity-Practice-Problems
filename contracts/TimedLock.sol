// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Timelock {
    address public owner;  // Address of the owner
    uint256 public unlockTime;  // Time for unlocking the amount
    uint256 public lockedAmount;  // Amount of ETH to lock

    event Locked(uint256 amount, uint256 unlockTime);  // Emit this event when ETH is locked
    event Withdrawn(uint256 amount);  // Emit this event when ETH is withdrawn

    constructor() {  // Sets the variable owner to the address of the person who deployed the contract
        owner = msg.sender;
    }

    function lock(uint256 _duration, uint256 _amountInEth) external payable {  // Function to lock ETH
        require(msg.sender == owner, "Not the owner");  // Ensures that only owner can lock ETH
        require(block.timestamp >= unlockTime, "Funds are already locked");  // Checks if unlock time has passed
        require(_amountInEth > 0, "Must specify a positive amount to lock");  // Checks if amount locked is positive

        // by default , Solidity operates in wei, so we have to convert ETH to wei
        uint256 _amountInWei = _amountInEth * 1 ether; // Converting ETH to wei
        require(msg.value == _amountInWei, "Sent ETH does not match specified amount");  // Checks if amount transferred matches with the amount specofied

        lockedAmount = _amountInWei;
        unlockTime = block.timestamp + _duration;

        emit Locked(lockedAmount, unlockTime);
    }

    function withdraw() external {  // Function to withdraw ETH
        require(msg.sender == owner, "Not the owner"); // Ensures that only owner can withdraw
        require(block.timestamp >= unlockTime, "Funds are still locked");  // Checks if unlock time has passed
        require(lockedAmount > 0, "No funds to withdraw"); // Checks if amount of ETH locked was positive

        uint256 amountToWithdraw = lockedAmount;
        lockedAmount = 0; // Resets the locked amount

        payable(owner).transfer(amountToWithdraw); // Transfers ETH back to owner

        emit Withdrawn(amountToWithdraw);
    }
}