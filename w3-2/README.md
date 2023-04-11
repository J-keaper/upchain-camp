# 合约升级

问题：合约⼀旦部署，便不可更改。合约中有错误如何修复？要添加额外功能，要怎么办？

解决：将数据与逻辑分开，用户调用 Proxy 合约(持有数据)，Proxy 合约调用 Deletegate 合约

[EIP-1967](https://eips.ethereum.org/EIPS/eip-1967)

[Research on the Collisions issues between EVM Storage Layout and Upgrade Proxy Pattern](https://mirror.xyz/zer0luck.eth/-7_tRRhql4TOQp-y9GQS1jVf-ev_QmId9vTKEdbF2Hw)

[Upgrades Plugins - OpenZeppelin Docs](https://docs.openzeppelin.com/upgrades-plugins/1.x/)

# MultiCall

# Gas 技巧
