
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18; // version of solidity to use in compliler 
 // a contract function where the contract is written.
contract ArrayManipulation{          
uint[] public array;   // we initialise a public array and domt define  so as to not fix size

function addElmnt(uint item) public{
    array.push(item);                            // pushes into the array
}

function removeElmnt() public{ 
    array.pop();                            // removes the last element from array
}

function viewArray () public view returns(uint[] memory) {
return array;
}

}