// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.26 and less than 0.9.0
pragma solidity ^0.8.26;

contract ChallengeCalculator {
    uint public lastResult;

    function add(uint256 _number1, uint256 _number2) public returns (uint256)  {
        lastResult = _number1 + _number2;
        return lastResult;
    }

    function multiply(uint256 _number1) public returns (uint256) {
        lastResult = lastResult * _number1;
        return lastResult;
    }

    function divide(uint256 _number1) public returns (uint256) {
        require(_number1 != 0, "Pembagian dengan nol tidak diperbolehkan");
        lastResult = lastResult / _number1;
        return lastResult;
    }

    function clear() public {
        lastResult = 0;
    }

    function getLastResult() public view returns (uint256) {
        return lastResult;
    }
}