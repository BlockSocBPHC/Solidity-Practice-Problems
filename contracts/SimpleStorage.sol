// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract SimpleStorage{
    string public data;

        function set(string memory value) public{
            data = value;
        }
        
        function get() public view returns (string memory) {
    _address public data;

        function set(_address value) public{
            data = value;
        }
        
        function get() public view returns (_address) {
    address public data;

        function set(address value) public{
            data = value;
        }
        
        function get() public view returns (address) {
            return data;
        }
        
}
