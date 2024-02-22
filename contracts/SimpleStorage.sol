// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

contract Store {
  uint value;
 
  function set(uint val) public 
  {
    value=val;
  }
  function get() public view returns (uint) {
    return value;
  }
}
    
