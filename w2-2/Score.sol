// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Address.sol";

contract Score {
    address public owner; // 管理员
    address public teacher; // 教师
    mapping(address => bool) studentExist; // 学生是否存在
    mapping(address => uint) studentScore; // 分数

    constructor() {
        owner = msg.sender;
    }

    // 学生可以查询自己的分数
    function queryScore() public view returns (uint) {
        require(studentExist[msg.sender], "student score not found");
        return studentScore[msg.sender];
    }

    // 老师可以查询所有学生的分数
    function queryScore(
        address student
    ) public view onlyTeacher returns (uint) {
        require(studentExist[student], "student score not found");
        return studentScore[student];
    }

    // 老师可以设置分数
    function setScore(address student, uint score) external onlyTeacher {
        require(score <= 100, "Score is invalid");
        studentExist[student] = true;
        studentScore[student] = score;
    }

    // 修改老师
    function setTeacher(address _teacher) public onlyOwner {
        require(
            Address.isContract(_teacher),
            "Teacher should is contract address"
        );
        teacher = _teacher;
    }

    modifier onlyTeacher() {
        require(teacher == msg.sender, "Not Teacher");
        _;
    }

    modifier onlyOwner() {
        require(owner == msg.sender, "Not Owner");
        _;
    }
}
