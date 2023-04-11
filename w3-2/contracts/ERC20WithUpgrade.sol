// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts/utils/Address.sol";

interface TokenRecipient {
    function tokenReceived(address sender, uint amount) external returns (bool);
}

contract KeaperV2 is ERC20Upgradeable {
    using Address for address;

    function initialize() external initializer {
        __ERC20_init("Keaper", "KEP");
        _mint(msg.sender, 100000 * 10 ** decimals());
    }

    function transferWithCallback(address recipient, uint256 amount) external {
        _transfer(msg.sender, recipient, amount);
        if (recipient.isContract()) {
            bool result = TokenRecipient(recipient).tokenReceived(
                msg.sender,
                amount
            );
            require(result, "token recipient fail");
        }
    }
}
