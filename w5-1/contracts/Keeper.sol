// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@chainlink/contracts/src/v0.8/AutomationCompatible.sol";

interface Vault {
    function totalAmount() external view returns (uint);

    function collect() external;
}

contract Keeper is AutomationCompatible {
    Vault vault;

    constructor(address _address) {
        vault = Vault(_address);
    }

    function checkUpkeep(
        bytes calldata /* checkData */
    )
        external
        view
        override
        returns (bool upkeepNeeded, bytes memory /* performData */)
    {
        upkeepNeeded = vault.totalAmount() >= 5e18;
    }

    function performUpkeep(bytes calldata /* performData */) external override {
        vault.collect();
    }
}
