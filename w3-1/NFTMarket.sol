// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

// NFT 交易市场
contract Market {
    IERC721 public immutable collection; // NFT 合约地址
    IERC20 public immutable token; // 交易Token地址
    mapping(uint => uint) public orderAmount; // 订单价格
    mapping(uint => uint8) public orderStatus; // 订单状态, 1:生效中, 2:已取消, 3:已成交

    constructor(address _collection, address _token) {
        collection = IERC721(_collection);
        token = IERC20(_token);
    }

    // // 买家需要授权NFT，以便在交易后转移给买家NFT
    // function approvalCollection() public {
    //     collection.setApprovalForAll(msg.sender, true);
    // }

    // 买家需要授权Token，以便在交易后转移给卖家Token
    // function approvalToken(uint _amount) public {
    //     token.approve(msg.sender, _amount);
    // }

    // 卖家 - 挂单
    function listOrder(uint _tokenId, uint amount) public ownToken(_tokenId) {
        require(orderStatus[_tokenId] != 1, "order has been listed");
        address owner = collection.ownerOf(_tokenId);
        require(
            collection.isApprovedForAll(owner, address(this)),
            "not approval"
        );
        orderAmount[_tokenId] = amount;
        orderStatus[_tokenId] = 1;
    }

    // 卖家 - 更新挂单价格
    function updateOrder(uint _tokenId, uint amount) public ownToken(_tokenId) {
        require(orderStatus[_tokenId] == 1, "order is invalid");
        address owner = collection.ownerOf(_tokenId);
        require(
            collection.isApprovedForAll(owner, address(this)),
            "not approval"
        );
        orderAmount[_tokenId] = amount;
    }

    // 卖家 - 取消订单
    function cancelOrder(uint _tokenId) public {
        require(orderStatus[_tokenId] == 1, "order is invalid");
        orderStatus[_tokenId] = 2;
    }

    // 查询订单
    // @return 订单是否有效，订单金额
    function getOrder(uint _tokenId) public view returns (bool, uint) {
        uint8 status = orderStatus[_tokenId];
        if (status != 1) {
            return (false, 0);
        }
        uint amount = orderAmount[_tokenId];
        return (true, amount);
    }

    // 买家 - 下单
    function acceptOrder(uint _tokenId) public {
        require(orderStatus[_tokenId] == 1, "order is invalid");
        uint amount = orderAmount[_tokenId];
        require(
            token.allowance(msg.sender, address(this)) >= amount,
            "allowance is not enough"
        );
        address owner = collection.ownerOf(_tokenId);
        require(
            collection.isApprovedForAll(owner, address(this)),
            "not approval"
        );

        token.transferFrom(msg.sender, owner, amount);
        collection.transferFrom(owner, msg.sender, _tokenId);
        orderStatus[_tokenId] = 3; // 订单已成交
    }

    modifier ownToken(uint _tokenId) {
        require(
            collection.ownerOf(_tokenId) == msg.sender,
            "token is not belong to you"
        );
        _;
    }
}
