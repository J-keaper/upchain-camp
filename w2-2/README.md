# 函数可见性

- public 内部/外部
- private 内部
- external 外部
- internal 内部及继承

# 合约特殊函数

- 构造函数 constructor
- getter 函数：public 变量默认生成 getter 函数
- receive 函数：接收以太币的时候会被调用
- fallback 函数：没有匹配函数标识符时,fallback 会被调⽤；如果是转账时，没有 receive 函数的话 fallback 函数也会被调用

# 函数修饰符

- view 不修改状态
- pure 不读取状态
- payable 表示调用函数可以被支付 ETH，可以用 msg.value 获取

## 自定义修饰符 modifier

⽤ Modifier 修饰⼀个函数， ⽤来添加函数的⾏为，如检查输⼊条件、控制访问、重⼊控制

# 错误处理

EVM 通过回退来保证事务性

- assert，条件检查，并在条件检查不满足的时候 抛出异常
- require，条件检查，并在条件检查不满足的时候 抛出异常
  > require 会剩余退回剩余的 gas， assert 不会
- revert("msg")， 终止运行并主动撤销状态修改
- Error 自定义错误，自定义错误占用空间更小，省 Gas

```
error NotOwner();
if(msg.sender != owner) revert NotOwner();
```

## 异常捕获

try/catch: 捕获合约中外部调⽤的异常

> 0.6 版本之前只能通过 call 函数接收返回值来处理

# 创建合约

- 外部创建合约(Create)
- 合约内部使用 New 关键字创建(Create)
- 最小代理合约，可以复用代码

  - EIP-1167
  - https://github.com/optionality/clone-factory

- create、create2：create2 可以确定性地创建合约
  - create 创建合约时通过创建者账户的 nonce 来计算确定
  - create2 是 通过合约代码字节码来创建

# 接口、继承、库

## 继承

> `is`关键字
> 实际上在链上只有一个合约被创建，父合约的代码会编译进子合约的代码

## 抽象合约

`abstract`关键字来声明抽象合约
不可被部署，可包含没有被实现的纯虚函数
`virutal`关键字表示该函数可以被子合约进行重写
`overide：`表示重写了父合约的函数
`super`关键字可以调用父合约函数实现

## 接口

主要用于合约之间的调用
没有状态变量，没有函数实现，没有构造方法，不能继承自其他接口

## 库

- 主要用于代码复用
- 如果库函数都是 internal 的，库代码会被嵌入到合约中
- 如果 库函数有 external 或者 public，库需要单独部署，在依赖库的合约部署时需要链接库
- 不能有状态变量、不能发送 ETH

# 事件

- 使用`event`定义事件
- 使用`emit`触发事件
- 事件中使⽤`indexed`修饰，表示对这个字段建⽴索引，⽅便外部对该字段过滤查找

# 函数重入

- 重入锁控制
- 先检查-再修改-再交互
