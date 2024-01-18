// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Splitter {
    address public recipient1;
    address public recipient2;

    constructor(address _recipient1, address _recipient2) {
        recipient1 = _recipient1;
        recipient2 = _recipient2;
    }

    function split() public payable {
        uint256 amountToSplit = msg.value * 4;
        payable(recipient1).transfer(amountToSplit);
        payable(recipient2).transfer(amountToSplit);
    }
}
