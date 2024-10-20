//SPDX-License-Identifier: MIT
pragma solidity 0.8.19; // solidity version

contract Election {
    // Candidate structure
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    // Mapping to store candidates
    mapping(uint => Candidate) public candidates;
    
    // Mapping to store votes
    mapping(address => bool) public voters;

    // Election state variables
    uint public candidatesCount;
    uint public totalVotes;
    address public admin;

    // Constructor to initialize the admin
    constructor() {
        admin = msg.sender;
    }

    // Event to be emitted when a new candidate is added
    event CandidateAdded(uint id, string name);

    // Event to be emitted when a vote is cast
    event VoteCast(address voter, uint candidateId);

    // Modifier to restrict access to admin only
    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action");
        _;
    }

    // Add a candidate to the election
    function addCandidate(string memory _name) public onlyAdmin {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
        emit CandidateAdded(candidatesCount, _name);
    }

    // Cast a vote for a candidate
    function vote(uint _candidateId) public {
        require(!voters[msg.sender], "You have already voted.");
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate ID.");
        
        voters[msg.sender] = true;
        candidates[_candidateId].voteCount++;
        totalVotes++;

        emit VoteCast(msg.sender, _candidateId);
    }

    // Get the details of a candidate
    function getCandidate(uint _candidateId) public view returns (string memory name, uint voteCount) {
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate ID.");
        Candidate memory candidate = candidates[_candidateId];
        return (candidate.name, candidate.voteCount);
    }

    // Get the total votes cast
    function getTotalVotes() public view returns (uint) {
        return totalVotes;
    }

    // Determine the winner based on the highest number of votes
    function getWinner() public view returns (string[] memory names, uint[] memory voteCounts) {
        uint winningVoteCount = 0;

        // Determine the highest vote count
        for (uint i = 1; i <= candidatesCount; i++) {
            if (candidates[i].voteCount > winningVoteCount) {
                winningVoteCount = candidates[i].voteCount;
            }
        }

        // Count how many candidates have highest vote count
        uint winnersCount = 0;
        for (uint i = 1; i <= candidatesCount; i++) {
            if (candidates[i].voteCount == winningVoteCount) {
                winnersCount++;
            }
        }

        // Create arrays to hold the winners' names and vote counts
        names = new string[](winnersCount);
        voteCounts = new uint[](winnersCount);
        uint index = 0;

        // Populate the winners' arrays
        for (uint i = 1; i <= candidatesCount; i++) {
            if (candidates[i].voteCount == winningVoteCount) {
                names[index] = candidates[i].name;
                voteCounts[index] = candidates[i].voteCount;
                index++;
            }
        }
    }
}
