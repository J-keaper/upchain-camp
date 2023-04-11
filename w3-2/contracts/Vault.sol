// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Vault {
    address public owner;
    address public tokenAddress;
    // account => balance
    mapping(address => uint) private tokenBalance;

    constructor(address _tokenAddress) {
        owner = msg.sender;
        tokenAddress = _tokenAddress;
    }

    function balanceOf() public view returns (uint) {
        return tokenBalance[msg.sender];
    }

    function totalAmount() public view returns (uint) {
        return IERC20(tokenAddress).balanceOf(address(this));
    }

    // 存款
    function deposite(uint _value) public {
        IERC20 token = IERC20(tokenAddress);
        token.transferFrom(msg.sender, address(this), _value);
        tokenBalance[msg.sender] += _value;
    }

    // 提款
    function withdraw(uint _value) public {
        require(tokenBalance[msg.sender] >= _value, "Balance Not Enough");
        IERC20 token = IERC20(tokenAddress);
        token.transfer(msg.sender, _value);
        tokenBalance[msg.sender] -= _value;
    }
}
