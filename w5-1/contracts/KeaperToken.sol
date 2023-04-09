// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract KeaperToken is ERC20 {
    constructor() ERC20("Keaper", "KEP") {
        _mint(msg.sender, 100000 * 10 ** decimals());
    }
}
