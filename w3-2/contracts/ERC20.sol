// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";

contract KeaperV1 is ERC20Upgradeable {
    function initialize() external initializer {
        __ERC20_init("Keaper", "KEP");
        _mint(msg.sender, 100000 * 10 ** decimals());
    }
}
