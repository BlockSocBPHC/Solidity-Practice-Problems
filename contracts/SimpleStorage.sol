// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract SimpleStorage{
    address public data;

        function set(address value) public{
            data = value;
        }
        
        function get() public view returns (address) {
            return data;
        }
        
}
