// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IScore {
    function setScore(address student, uint score) external;

    function queryScore(address student) external view returns (uint);
}

contract Teacher {
    function setScore(address class, address student, uint score) public {
        IScore(class).setScore(student, score);
    }

    function queryScore(
        address class,
        address student
    ) public view returns (uint) {
        return IScore(class).queryScore(student);
    }
}
