
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SharedWallet {
    mapping(address => uint256) private balances;
    mapping(address => bool) private isOwner;

    event OwnerAdded(address indexed owner);
    event OwnerRemoved(address indexed owner);
    event FundsDeposited(address indexed depositor, uint256 amount);
    event FundsWithdrawn(address indexed withdrawer, uint256 amount);
    event FundsTransferred(address indexed sender, address indexed recipient, uint256 amount);

    modifier onlyOwner() {
        require(isOwner[msg.sender], "Not an owner");
        _;
    }

    constructor(address[] memory initialOwners) {
        for (uint256 i = 0; i < initialOwners.length; i++) {
            require(initialOwners[i] != address(0), "Invalid owner address");
            isOwner[initialOwners[i]] = true;
            emit OwnerAdded(initialOwners[i]);
        }
    }

    function addOwner(address newOwner) external onlyOwner {
        require(newOwner != address(0), "Invalid owner address");
        require(!isOwner[newOwner], "Address is already an owner");
        isOwner[newOwner] = true;
        emit OwnerAdded(newOwner);
    }

    function removeOwner(address ownerToRemove) external onlyOwner {
        require(isOwner[ownerToRemove], "Address is not an owner");
        // Ensure that there is always at least one owner
        require(getOwnerCount() > 1, "Cannot remove the last owner");
        isOwner[ownerToRemove] = false;
        emit OwnerRemoved(ownerToRemove);
    }

    function depositFunds() external payable {
        require(msg.value > 0, "Must deposit a non-zero amount");
        balances[msg.sender] += msg.value;
        emit FundsDeposited(msg.sender, msg.value);
    }

    function withdrawFunds(uint256 amount) external onlyOwner {
        require(amount > 0, "Must withdraw a non-zero amount");
        require(amount <= balances[msg.sender], "Insufficient funds");
        payable(msg.sender).transfer(amount);
        balances[msg.sender] -= amount;
        emit FundsWithdrawn(msg.sender, amount);
    }

    function transferFunds(address recipient, uint256 amount) external onlyOwner {
        require(recipient != address(0), "Invalid recipient address");
        require(amount > 0, "Must transfer a non-zero amount");
        require(amount <= balances[msg.sender], "Insufficient funds");
        balances[msg.sender] -= amount;
        balances[recipient] += amount;
        emit FundsTransferred(msg.sender, recipient, amount);
    }

    function getBalance() external view returns (uint256) {
        return balances[msg.sender];
    }

    function getOwnerCount() public view returns (uint256) {
        uint256 count = 0;
        for (uint256 i = 0; i < msg.data.length; i++) {
            if (isOwner[msg.sender]) {
                count++;
            }
        }
        return count;
    }
}
