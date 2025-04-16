pragma solidity ^0.8.0;

contract BeachHouseRental {
// state variables 
    address payable public owner;
    bool public available;
    uint public ratePerDay;

    event Log(address indexed sender, string message);

// __init__
    constructor() {
        owner = payable(msg.sender);
        available = true;
        ratePerDay = 0.5 ether;
     }

     modifier onlyOwner() { 
        require(msg.sender == owner, "Modifier: Must be the owner!"); 
        _;
    }

 // Book beachhouse bid submission function    
    function bookBeachHouse(uint numDays) public payable {
        require(available, "Too late. You snooze, you lose");
        uint minOffer = ratePerDay * numDays;
        require(msg.value >=minOffer, "Take your broke ass home.");
        // owner.transfer(msg.value) 
        (bool sent,) = payable(owner).call{value: msg.value} ("");
        require(sent, "transfer failed.");
        available = false;
        emit Log(msg.sender, "Beach House Booked!");
    }
    function makeBeachHouseAvailable() public onlyOwner {
        //require(msg.sender == owner, "Only owner can call this method.");
        available = true;
        emit Log(msg.sender, "Beach House Available");
    }
    // change rate based on eth price and beach house demand 
    function updateRate(uint newRate) public {
        //require(msg.sender == owner, "Only owner can call this method.");
        ratePerDay = newRate;
        emit Log(msg.sender, "Beach House Rate Updated");
    }

    function buyBeachHouse() public payable {
        uint minOffer = 3 * 365 * ratePerDay;
        require (msg.value >=minOffer, "You are too broke for my home.");
        (bool sent, ) = payable(owner).call{value: msg.value} ("");
        require(sent, "Transfer failed.");
        owner = payable(msg.sender);
    }
    }