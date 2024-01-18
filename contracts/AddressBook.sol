// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AddressBook {
    mapping(address => string[]) private addressAliases;

    mapping(address => string[]) private addressContacts;

    function addContact(string memory addressalias, string memory contact) public {
    
        addressAliases[msg.sender].push(addressalias);

    
        addressContacts[msg.sender].push(contact);
    }

    
    function getContacts() public view returns (string[] memory) {
        return addressContacts[msg.sender];
    }

    
    function getAliases() public view returns (string[] memory) {
        return addressAliases[msg.sender];
    }
    function removeContact(string memory contact) public {

        for (uint256 i = 0; i < addressContacts[msg.sender].length; i++) {
            if (keccak256(bytes(addressContacts[msg.sender][i])) == keccak256(bytes(contact))) {
    
                delete addressContacts[msg.sender][i];
                break;
            }
        }
    }


    function removeAlias(string memory addressalias) public {
        for (uint256 i = 0; i < addressAliases[msg.sender].length; i++) {
            if (keccak256(bytes(addressAliases[msg.sender][i])) == keccak256(bytes(addressalias))) {
            
                delete addressAliases[msg.sender][i];
                break;
            }
        }
    }
}

