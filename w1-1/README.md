# 总结

## 区块链基础概念

## 以太坊

### 智能合约

### 账户&交易

### EVM

### 钱包

### Gas

### Solidity

### Remix

# 作业

## 转账交易

- 转账交易 Hash：[0xcf3c3a42dc6e324535900f9f07b03c85e468a6826a21fc4592f7e9fbd97f9be2](https://goerli.etherscan.io/tx/0xcf3c3a42dc6e324535900f9f07b03c85e468a6826a21fc4592f7e9fbd97f9be2)

## 合约代码

```
// SPDX-License-Identifier: GPL-3.0

pragma solidity  >=0.7.0 <0.9.0;

contract Counter {

    uint public value;

    constructor(){
        value = 0;
    }

    function add(uint incr)  public {
        value = value + incr;
    }

}
```

## 合约部署

- 合约部署地址：[0xddcdcf87d9c64418e471bab168785a85d24b0664](https://goerli.etherscan.io/address/0xddcdcf87d9c64418e471bab168785a85d24b0664)
- 创建合约交易：[0xad2d4b8488da28748745fbd45a1a251b4aeedc1bf3f1922466a7264fe100a1c0](https://goerli.etherscan.io/tx/0xad2d4b8488da28748745fbd45a1a251b4aeedc1bf3f1922466a7264fe100a1c0)

## 发起交易

- 交易 Hash：[0x36c1e61db85fb33d71ecc16a601562d53b942010e75c4b273f10ec746d374df1](https://goerli.etherscan.io/tx/0x36c1e61db85fb33d71ecc16a601562d53b942010e75c4b273f10ec746d374df1)
