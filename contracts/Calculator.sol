// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.26 and less than 0.9.0
pragma solidity ^0.8.26;

contract Calculator {

    function add(int _number1, int _number2) public pure returns (int) {
        return _number1 + _number2;
    }

    function subtract(int _number1, int _number2) public pure returns (int) {
        return _number1 - _number2;
    }

    function divide(int _number1, int _number2) public pure returns (int) {
        return _number1 / _number2;
    }

    function muliply(int _number1, int _number2) public pure returns (int) {
        return _number1 * _number2;
    }

    function power(uint _number1, uint _number2) public pure returns (uint) {
        return _number1 ** _number2;
    }

    function root(uint256 _number1) public pure returns (uint256) {
        if (_number1 == 0) return 0;
        uint256 z = (_number1 + 1) / 2;
        uint256 y = _number1;
        while (z < y) {
            y = z;
            z = (_number1 / z + z) / 2;
        }
        return y;
    }

    function Modulo(uint256 _number1, uint256 _number2) public pure returns (uint256) {
        require(_number2 != 0, "Pembagi tidak boleh nol");
        return _number1 % _number2;
    }

     function factorial(uint256 n) public pure returns (uint256) {
        require(n >= 0, "Angka harus non-negatif");
        
        uint256 result = 1;
        for (uint256 i = 1; i <= n; i++) {
            result *= i;
        }
        
        return result;
    }
}