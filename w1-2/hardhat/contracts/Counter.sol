// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "hardhat/console.sol";

contract Counter {
    uint public value;
    address public owner;

    constructor(uint val) {
        value = val;
        owner = msg.sender;
        console.log("owner: %s", owner);
    }

    function add(uint incr) public onlyOwner {
        value = value + incr;
        console.log("value: %s", value);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "only owner");
        _;
    }
}
