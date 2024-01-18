// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract SimpleStorage{
    string public data;

        function set(string memory value) public{
            data = value;
        }
        
        function get() public view returns (string memory) {
            return data;
        }
        
}
