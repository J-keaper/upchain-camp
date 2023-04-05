// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC777/ERC777.sol";

contract Keaper is ERC777 {
    constructor(
        uint256 initialSupply,
        address[] memory defaultOperators
    ) ERC777("Keaper", "KEP", defaultOperators) {
        _mint(msg.sender, initialSupply, "", "");
    }
}

contract Vault is IERC777Recipient {
    IERC1820Registry internal constant _ERC1820_REGISTRY =
        IERC1820Registry(0x1820a4B7618BdE71Dce8cdc73aAB6C95905faD24);

    // (account => balance)
    mapping(address => uint) private balance;
    address public immutable token;

    constructor(address _token) {
        _ERC1820_REGISTRY.setInterfaceImplementer(
            address(this),
            keccak256("ERC777TokensRecipient"),
            address(this)
        );
        token = _token;
    }

    function balancOf() public view returns (uint) {
        return balance[msg.sender];
    }

    // 提款
    function withdraw(uint _value) public {
        require(balance[msg.sender] >= _value, "Balance Not Enough");
        IERC20 token = IERC20(token);
        token.transfer(msg.sender, _value);
        balance[msg.sender] -= _value;
    }

    // 存款回调
    function tokensReceived(
        address operator,
        address from,
        address to,
        uint256 amount,
        bytes calldata userData,
        bytes calldata operatorData
    ) external {
        require(msg.sender == token, "msg.sender is not token address");
        require(to == address(this), "receiver is not this contract");
        balance[from] += amount;
    }
}
