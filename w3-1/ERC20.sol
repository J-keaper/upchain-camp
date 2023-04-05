// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Keaper is ERC20 {
    constructor() ERC20("Keaper", "KEP") {
        _mint(msg.sender, 100000 * 10 ** decimals());
    }
}

contract Vault {
    // tokenAddress => (account => balance)
    mapping(address => mapping(address => uint)) tokenBalance;

    function balancOf(address _tokenAddress) public view returns (uint) {
        return tokenBalance[_tokenAddress][msg.sender];
    }

    // 存款
    function deposite(address _tokenAddress, uint _value) public {
        IERC20 token = IERC20(_tokenAddress);
        token.transferFrom(msg.sender, address(this), _value);
        tokenBalance[_tokenAddress][msg.sender] += _value;
    }

    // 提款
    function withdraw(address _tokenAddress, uint _value) public {
        require(
            tokenBalance[_tokenAddress][msg.sender] >= _value,
            "Balance Not Enough"
        );
        IERC20 token = IERC20(_tokenAddress);
        token.transfer(msg.sender, _value);
        tokenBalance[_tokenAddress][msg.sender] -= _value;
    }
}
