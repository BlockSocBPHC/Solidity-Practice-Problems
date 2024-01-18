// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract TimeLockedWallet {
    using SafeMath for uint256;

    mapping(address => uint256) private balances;
    mapping(address => uint256) private lockTimes;

    event FundsDeposited(address indexed depositor, uint256 amount, uint256 lockTime);
    event FundsWithdrawn(address indexed withdrawer, uint256 amount);

    modifier onlyAfterLockTime(address _user) {
        require(block.timestamp >= lockTimes[_user], "Funds are still locked");
        _;
    }

    function deposit(uint256 _lockTime) external payable {
        require(_lockTime > block.timestamp, "Lock time must be in the future");
        
        balances[msg.sender] = balances[msg.sender].add(msg.value);
        lockTimes[msg.sender] = _lockTime;

        emit FundsDeposited(msg.sender, msg.value, _lockTime);
    }

    function increaseLockTime(uint256 _newLockTime) external {
        require(_newLockTime > lockTimes[msg.sender], "New lock time must be in the future");

        lockTimes[msg.sender] = _newLockTime;
    }

    function withdraw() external onlyAfterLockTime(msg.sender) {
        uint256 amount = balances[msg.sender];
        require(amount > 0, "No funds available for withdrawal");

        balances[msg.sender] = 0;
        lockTimes[msg.sender] = 0;

        payable(msg.sender).transfer(amount);

        emit FundsWithdrawn(msg.sender, amount);
    }

    function getBalance() external view returns (uint256) {
        return balances[msg.sender];
    }

    function getLockTime() external view returns (uint256) {
        return lockTimes[msg.sender];
    }
}

