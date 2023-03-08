// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Counter {
    uint public value;

    constructor() {
        value = 0;
    }

    function add(uint incr) public {
        value = value + incr;
    }
}
