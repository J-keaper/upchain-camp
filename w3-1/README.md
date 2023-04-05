# EIP/ERC

- EIP：https://eips.ethereum.org/all
- ERC：https://eips.ethereum.org/erc
  - https://eips.ethereum.org/EIPS/eip-20

EIP 分类

- CORE
- ERC
- NETWORK
- INTERFACE

常用开发库

- [OpenZeppelin 标准](https://docs.openzeppelin.com/contracts/4.x/)
- [Solmate](https://github.com/transmissions11/solmate)

# ERC20

- https://eips.ethereum.org/EIPS/eip-20
- 同质化代币，可以用数量表示的货币

## 标准接口

```solidity
// 名称
function name() public view returns (string)
// 符号
function symbol() public view returns (string)
// 精度
function decimals() public view returns (uint8)
// 总量
function totalSupply() public view returns (uint256)
// 余额
function balanceOf(address _owner) public view returns (uint256 balance)
// owner主动转账
function transfer(address _to, uint256 _value) public returns (bool success)
// 被授权者转账
function transferFrom(address _from, address _to, uint256 _value) public returns (bool success)
// owner授权
function approve(address _spender, uint256 _value) public returns (bool success)
// 查询授权额度
function allowance(address _owner, address _spender) public view returns (uint256 remaining)


event Transfer(address indexed _from, address indexed _to, uint256 _value)
event Approval(address indexed _owner, address indexed _spender, uint256 _value)

```

ERC20 问题：

- 转账⽆法携带额外的信息。
- 没有转账回调
- 误转入合约是无法取出的
- 依赖授权是依赖授权的，所以一般会有两笔交易

# ERC777

- 通过 send 方法可以在转账时携带消息。
- 通过合约回调也可以判断合约有没有实现回调，如果没有注册回调则交易失败，避免误转入合约导致交易锁死。
- 通过合约回调可以省去授权操作，直接在回调函数中实现操作。

## ERC1820

- ERC777 是通过 ERC1280(全局注册表)来判断合约是否有注册监听回调的

## 自己实现 ERC20 callback

ERC777 Gas 比较高，可以自己实现 Callback。

# ERC20-Premit EIP2612

授权和转账是在同一笔交易中的进行的，授权是在 premit 方法中进行的，参数中的签名是在线上生成。
相当于授权是在线下进行的。

签名格式：ERC712(可读性更强的签名格式)

## Uniswap Permit2

- [Permit](https://github.com/Uniswap/permit2)

- Uniswap Permit2 结合了 approve 与 erc2612 - Permit

# ERC20 问题

- 有些 Token 没有返回值
- 有些 Token 失败没有回退

最佳实践：使用 Openzeplin 的 SafeERC20 safeTransfer

# ERC721

- 非同质化 Token，每个 Token 都有唯一的 ID
- 每个 Token 有⼀个对应 URI 来描述属性

## 元数据的存储

- IPFS：去中心化存储协议(Pinata)
- Arweave：去中心化存储区块链

- [Metadata 标准](https://docs.opensea.io/docs/metadata-standards)

## 组织一个 NFT

- 图⽚上传到如 IPFS （Pinata）
- 编写元数据⽂件(JSON)
- 元数据⽂件上传到 IPFS
- 调⽤ mint() ⽅法
- Opensea 等 NFT 市场查看

## ERC721 扩展

- [ERC721A](https://github.com/chiru-labs/ERC721A)
- ⽤可升级合约单独展示元数据，可以方便修改元数据。

## NFT Market

- OpenSea
- X2Y2
- Element

## SBT

- 无法转让的 NFT = SBT

# ERC1155

- ERC20 与 ERC721 的结合，兼顾独特性与数量，一个 ID 可能有多份。
