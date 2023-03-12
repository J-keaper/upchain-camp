# 总结

## Remixd

在 remix 中访问本地文件

## Visual Solidity 插件

## Truffle + Ganache

### Truffle 项目结构

    - truffle-config.js文件：truffle配置（编译版本，网络等）
    - contracts 合约文件夹
    - migrations 部署脚本
    - test 测试脚本

### 命令

- truffle init 初始化项目文件夹
- truffle unbox 使用模板初始化项目
- truffle compile 编译合约文件
- truffle migrate 部署文件
- truffle test 测试
- truffle exec 执行脚本
- truffle console 可以在控制台和合约交互
- truffle develop 可以在控制台和合约交互(会自动启动 Ganache)

### 测试

- JavaScript 测试
  - 测试框架：[Mocha](https://mochajs.org/) 和 [Chai](https://www.chaijs.com/)
- Solidity 测试

## Hardhat

### 项目结构

- contracts：合约文件
- scripts: JS 脚本文件
- test：测试文件

### 命令

- `hardhat` 初始化项目
- `hardhat compile` 编译
- `hardhat run /path/to/script` 执行脚本(部署)
- `hardhat node` 启动本地区块链环境
- `hardhat verify` 开源合约代码

### Hardhat 技巧

- `hardhat/console.sol` 在合约代码中输出信息，信息是打印在节点日志中的
- `HARDHAT_NETWORK` 环境变量也可以指定网络

## Foundry

包含三个命令工具：

- forge：用来测试、构建和部署智能合约
- cast：执行以太网 RPC 调用的命令行工具
- anvil：创建本地测试网节点，也可以用来分叉其他与 EVM 兼容的网络

### 安装

### 项目结构

- fountry.toml：项目配置文件
- src：合约目录
- test: 测试目录
- script: 部署脚本目录
- lib：依赖库，默认安装 forge 标准库

### 命令

- `forge init`: 初始化项目
- `forge build`: 编译
- `forge create`: 部署
- `forge script`: 使用脚本部署

## 作业

### 修改 OnlyOwner

```solidity
// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "hardhat/console.sol";

contract Counter {
    uint public value;
    address public owner;

    constructor(uint val) {
        value = val;
        owner = msg.sender;
        console.log("owner: %s", owner);
    }

    function add(uint incr) public onlyOwner {
        value = value + incr;
        console.log(value + 100);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "only owner");
        _;
    }
}
```

测试代码：

```js
const { expect } = require("chai");

describe("Counter", function () {
  let counter, owner, otherAccount;

  before(async function () {
    [owner, otherAccount] = await ethers.getSigners();
    console.log(
      `owner:${owner.toString()}, otherAccount: ${otherAccount.toString()}`
    );

    const Counter = await ethers.getContractFactory("Counter");
    counter = await Counter.deploy(2);
    await counter.deployed();
    console.log("counter deployed:" + counter.address);
  });

  it("init equal 2", async function () {
    expect(await counter.value()).to.equal(2);
  });

  it("add 2 equal 4", async function () {
    await counter.add(2);
    expect(await counter.value()).to.equal(4);
  });

  it("owner call success", async function () {
    expect(await counter.connect(owner).add(2)).to.be.ok;
  });

  it("other account call fail", async function () {
    await expect(counter.connect(otherAccount).add(2)).to.be.revertedWith(
      "only owner"
    );
  });
});
```

### 部署 goerli 网络并 Verify

- 合约地址：0xDF6AAA1F64E96Ec4ba704583C8Ef9f10676F74DC
- Verify: https://goerli.etherscan.io/address/0xdf6aaa1f64e96ec4ba704583c8ef9f10676f74dc#code
