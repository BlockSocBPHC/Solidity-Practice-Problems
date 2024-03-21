//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract HotelRoom {
    enum Statuses { Vacant, Occupied }
    Statuses public currentStatus;

    event Occupy(address _occupant, uint _value);

    address payable public owner;

    uint public roomPrice;


    constructor(uint _roomPrice) {
        owner = payable(msg.sender);
        currentStatus = Statuses.Vacant;
        roomPrice = _roomPrice;
    }

    modifier onlyWhileVacant {
        require(currentStatus == Statuses.Vacant, "Room is currently occupied.");
        _;
    }

    modifier costs(uint _amount) {
        require(msg.value >= _amount, "Not enough Ether provided.");
        _;
    }

    function bookRoom() public payable onlyWhileVacant costs(roomPrice) {
        currentStatus = Statuses.Occupied;
        owner.transfer(msg.value);
        emit Occupy(msg.sender, msg.value);
    }

    function changeRoomPrice(uint _newPrice) public {
        require(msg.sender == owner, "Only the owner can change the room price.");
        roomPrice = _newPrice;
    }
}