//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9; //defining solidity version

contract ownerIsGod{
   
    address public owner;  //setting the address of deployer with variable 'owner' and declaring his address publically
   
    constructor() {     // Constructor sets the deployer as the initial owner
        owner = msg.sender;
    }
    
    modifier onlyOwner() {   //Making a modifier which makes sure that the function can only be run by 'owner'
        require(msg.sender == owner, "Not the contract owner"); //require statment which checks if the caller is owner or sends the error message
        _;
    }

    mapping(address => uint256) balances; //mapping the address of funder to the amount he funded

    struct fundersInfo{       //defining the structure of the array where the data of funders will be stored
        address funder;
        uint256 amountFunded;
    }

    fundersInfo[] fundersinfo;   //the array where all the funder's data will be stored
    
    function FundAmount() public payable {           //defining a function where people can make payments and give funds to be stored in the contract
        require(msg.value > 1e16, "Transfer at least 0.01 ETH");   //putting a minimum transfer limit using require which wont run the code afterwards in the funciton if limit is less than the required limit, 1e16 means 10^^16 wei = 0.01 ETH
        balances[msg.sender] += msg.value;  //if the amount > 0.01 ETH, this line add the amount donated by person in the mapped data
        fundersinfo.push(fundersInfo(msg.sender, balances[msg.sender] )); //pushing the transaction recorded into an array
    }
    
    function GetBalance(address _address) public view onlyOwner returns (uint256) {   //function to read the amount an address donated
        return balances[_address];
    }

    function FundInputTransactions() public view onlyOwner returns (fundersInfo[] memory) {  //displays all the transactions in the array
        return fundersinfo;
    }

    uint256 public _WithdrawnAmount = 0; //declaring the variable to store the amount that owner withdrew
    
    function withdrawnAmount(uint256 _amountTaken) public onlyOwner{   //function which lets the owner withdraw funds fromm the contract
    bool sendSuccess = payable(msg.sender).send(_amountTaken);      //typecasting msg.sender address to payable address and using the send function to withdraw 
    require(sendSuccess, "Send failed");        //require statement to give an error message in case there was an error
    _WithdrawnAmount += _amountTaken;       //updating the variable to store the total amount that owner withdrew in case the transaction was success
    }
    }
