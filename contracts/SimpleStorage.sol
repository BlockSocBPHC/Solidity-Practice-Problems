// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract SimpleStorage{
    _address public data;

        function set(_address value) public{
            data = value;
        }
        
        function get() public view returns (_address) {
            return data;
        }
        
}
