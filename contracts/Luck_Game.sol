//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LuckGame {
    address public owner;
    uint256 public playCost;
    uint256 public lockoutTurns;
    uint256 public lockoutTime;
    uint256 public lastPlayedTimestamp;
    uint256 public totalCollected;
    address[] public players;

    constructor(uint256 _playCost, uint256 _lockoutTurns, uint256 _lockoutTime) {
        owner = msg.sender;
        playCost = _playCost;
        lockoutTurns = _lockoutTurns;
        lockoutTime = _lockoutTime;
        lastPlayedTimestamp = 0;
        totalCollected = 0;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only contract owner can call this function");
        _;
    }

    function play() external payable {
        require(msg.value == playCost, "Incorrect payment amount");
        require(lockoutTurns == 0 || block.timestamp >= lastPlayedTimestamp + lockoutTime, "You cannot play right now");

        if (!isPlayer(msg.sender)) {
            players.push(msg.sender);
        }

        totalCollected += msg.value;
        lastPlayedTimestamp = block.timestamp;
    }

    function selectWinner() external onlyOwner {
        require(players.length > 0, "No players yet");
        uint256 randomNumber = uint256(keccak256(abi.encodePacked(block.difficulty, block.timestamp, players.length)));
        uint256 winnerIndex = randomNumber % players.length;
        address winner = players[winnerIndex];
        payable(winner).transfer(totalCollected);
        totalCollected = 0;
        delete players;
    }

    function isPlayer(address player) private view returns (bool) {
        for (uint256 i = 0; i < players.length; i++) {
            if (players[i] == player) {
                return true;
            }
        }
        return false;
    }

    function setPlayCost(uint256 _playCost) external onlyOwner {
        playCost = _playCost;
    }

    function setLockoutTurns(uint256 _lockoutTurns) external onlyOwner {
        lockoutTurns = _lockoutTurns;
    }

    function setLockoutTime(uint256 _lockoutTime) external onlyOwner {
        lockoutTime = _lockoutTime;
    }

    function getContractBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
