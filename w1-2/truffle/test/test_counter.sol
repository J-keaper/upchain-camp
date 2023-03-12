// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Counter.sol";

contract TestCounter {
    function testAdd() public {
        Counter counter = Counter(DeployedAddresses.Counter());
        counter.add(2);

        Assert.equal(counter.value(), 4, "value is not right");
    }
}
