# Solidity 语法

## 数据类型

### 值类型

- 布尔
- 整型(int/uint, uint8、uint16、...、uint256)
- 定长字节数组
- 定长浮点数
- 枚举
- 地址类型

### 引用类型

引用类型分为 数组 和 结构体

#### 数组

- uint[10] 固定长度
- uint[] 可变长度
- arr[2]，下标访问，从 0 开始
- arr[2] = 3 //赋值

- bytes、string 是⼀种特殊的数组

方法：

- length 属性
- push()、push(x)
- pop()

> 数组 for 循环的时候需要注意 gas 问题
> 删除数组中指定位置元素的时候也要避免遍历，而是将最后一个元素补到空位，然后执行 pop

#### 结构体

#### 映射类型(Map)

只能作为状态变量(storage)

## 数据存储位置

- memory
- storage
- calldata

不同位置的引用赋值，会需要拷贝数据
相同位置的引用类型赋值，不需要拷贝

## Solidity 全局变量/函数

### 区块/消息/交易

- block.number、
- msg.sender、
- tx.origin、

> https://learnblockchain.cn/docs/solidity/units-and-global-variables.html#special-variables-and-functions

## ABI

ABI 接⼝描述： 定义如何与合约交互
调用一个合约其实就是将 ABI 编码后的方法和参数作为 Inputdata 发送到链上

ABI 编码包括 函数选择器和参数编码，在链下可以通过 ABI 描述文件（Json）生成 ABI 编码数据

## 地址/合约

### 地址类型

- 20 个字节
- address payable, 表示可⽀付地址，可调⽤ transfer 和 send

- balance 返回地址余额(`add.balance`)
- transfer(`add.transfer(x)`)，失败抛出异常，最大 gas 是 2300
- send(`add.send(x)`)，失败返回 false

### 合约

- 每个合约都是⼀个类型，可声明⼀个合约类型
- 合约可以显式转换为 address 类型，从⽽可以使⽤地址类型的成员函数。

### 合约调用

#### call，合约调用，切换上下文

`<address>.call(bytes memory) returns (bool, bytes memory) `

```
function lowCallCount(address addr) public {
    bytes memory methodData = abi.encodeWithSignature("count()");
    addr.call(methodData);
}
```

和直接调用函数的区别在于 底层调⽤失败不是发⽣异常（ revert）， ⽽是⽤返回值表示

可以附加转账的合约调用

- transfer 转账有最大 2300gas，但向合约转账可能会调用方法，所以 gas 会超过限制，所以可以使用 call 方法附带转账

#### delegatecall，合约调用，不切换上下文

- 使用其他库的代码
- 可以调用合约自己，实现 Multicall
- 如果访问到 target 的 storage 变量，需要保证源合约和目标合约的存储结构一致

#### staticcall
