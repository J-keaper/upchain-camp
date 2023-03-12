// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/Counter.sol";

contract CounterScript is Script {
    address internal deployer;
    string internal mnemonic;

    function setUp() public {
        mnemonic = vm.envString("MENMONIC");
        (deployer, ) = deriveRememberKey(mnemonic, 0);
    }

    function run() public broadcaster {
        Counter counter = new Counter();
        console.log("deployed on %s", address(counter));
    }

    modifier broadcaster() {
        vm.startBroadcast(deployer);
        _;
        vm.stopBroadcast();
    }
}
