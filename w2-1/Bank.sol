// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Bank {
    mapping(address => uint) private balance;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function fund() public payable {
        balance[msg.sender] += msg.value;
    }

    function withdraw() public {
        require(balance[msg.sender] > 0, "no monry in bank");
        uint amount = balance[msg.sender];
        balance[msg.sender] = 0;
        payable(msg.sender).transfer(amount);
    }

    function getBalance(address addr) public view onlyOwner returns (uint) {
        return balance[addr];
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "only owner");
        _;
    }
}
