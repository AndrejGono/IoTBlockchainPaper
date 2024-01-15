// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SmartHomeAccess {
    address public owner;
    mapping(address => bool) public accessList;

    // Event declarations
    event AccessGranted(address indexed _user);
    event AccessRevoked(address indexed _user);
    event DoorOpened(address indexed _user);
    event DoorClosed(address indexed _user);

    // Constructor sets the owner
    constructor() {
        owner = msg.sender;
    }

    // Modifier to restrict functions to the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    // Grant access to a user
    function grantAccess(address _user) public onlyOwner {
        accessList[_user] = true;
        emit AccessGranted(_user);
    }

    // Revoke access from a user
    function revokeAccess(address _user) public onlyOwner {
        accessList[_user] = false;
        emit AccessRevoked(_user);
    }

    // Function to open door
    function openDoor() public {
        require(accessList[msg.sender] == true, "Access denied");
        emit DoorOpened(msg.sender);
    }

    // Function to close door
    function closeDoor() public {
        require(accessList[msg.sender] == true, "Access denied");
        emit DoorClosed(msg.sender);
    }
}
