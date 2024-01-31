// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AddressBook{
    struct User{
        string name;
        string home_address;
    }
    

    User[] public users;
    mapping (address => User) private add_to_user;



    function addUser(string memory _name, string memory _home_address) public{
    add_to_user[msg.sender] = User(_name, _home_address);
    users.push(add_to_user[msg.sender]);

    function split() public payable {
        uint256 amountToSplit = 2*msg.value / 4;
        payable(recipient1).transfer(amountToSplit);
        payable(recipient2).transfer(amountToSplit);
    }




}
