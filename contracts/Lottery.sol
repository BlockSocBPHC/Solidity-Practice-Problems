// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

//A simple lottery contract where users can buy tickets and a winner is selected randomly.
contract Lottery {
    // State variables
    address public owner; // Owner of the contract
    uint public ticketPrice; // The price for one lottery ticket
    address[] public players; // Array to hold all participants
    uint public lotteryEndTime; // Timestamp for the end of the lottery

    // Constructor to initialize contract variables
    constructor(uint _ticketPrice, uint _duration) {
        owner = msg.sender; // The deployer is the contract owner
        ticketPrice = _ticketPrice; // Set the ticket price
        lotteryEndTime = block.timestamp + _duration; // Set the lottery end time
    }

    // Modifier to restrict access to only the contract owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    // Modifier to ensure the lottery is still active
    modifier lotteryActive() {
        require(block.timestamp < lotteryEndTime, "The lottery has ended");
        _;
    }

    // Function for users to buy tickets and enter the lottery
    function buyTicket() public payable lotteryActive {
        require(msg.value == ticketPrice, "Please send the exact ticket price");

        // Add the buyer to the players array
        players.push(msg.sender);
    }

    // Function to get all the players in the lottery
    function getPlayers() public view returns (address[] memory) {
        return players;
    }

    // Function for the owner to pick a random winner (can only be called after the lottery ends)
    function pickWinner() public onlyOwner {
        require(block.timestamp >= lotteryEndTime, "The lottery is still ongoing");
        require(players.length > 0, "No players in the lottery");

        // Generate a pseudo-random number to pick a winner
        uint randomIndex = getRandomNumber() % players.length;

        // Pay the winner and reset the lottery
        payWinner(players[randomIndex]);
        
        delete players; // Reset or clear your array;
    }

    // Helper function to generate a pseudo-random number (not secure for production)
    function getRandomNumber() private view returns (uint) {
        // Combine block difficulty, timestamp, and number of players to generate a pseudo-random number
        // Use block.prevrandao instead of block.difficulty (since Paris hard fork)
        return uint(keccak256(abi.encodePacked(block.prevrandao, block.timestamp, players.length)));
    }

    // Internal function to transfer the prize pool to the winner
    function payWinner(address winner) internal {
        // Transfer the total balance of the contract to the winner
        payable(winner).transfer(address(this).balance);
    }
}
