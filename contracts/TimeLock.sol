// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TimeLockedAllowance {

    struct Account {
        uint256 balance;
        uint256 lockTime;
    }

    mapping(address => Account) private balances;

    event Deposit(address indexed account, uint256 amount);
    event Withdrawal(address indexed account, uint256 amount);
    event LockTimeIncreased(address indexed account, uint256 newLockTime);

    function deposit() external payable {
        balances[msg.sender].balance += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw() external {
        require(block.timestamp >= balances[msg.sender].lockTime, "Funds are still locked");
        
        uint256 amount = balances[msg.sender].balance;
        balances[msg.sender].balance = 0;
        
        payable(msg.sender).transfer(amount);
        emit Withdrawal(msg.sender, amount);
    }

    function increaseLockTime(uint256 newLockTime) external {
        require(newLockTime > balances[msg.sender].lockTime, "New lock time must be greater");
        balances[msg.sender].lockTime = newLockTime;
        emit LockTimeIncreased(msg.sender, newLockTime);
    }

    function getBalance() external view returns (uint256) {
        return balances[msg.sender].balance;
    }

    function getLockTime() external view returns (uint256) {
        return balances[msg.sender].lockTime;
    }
}

