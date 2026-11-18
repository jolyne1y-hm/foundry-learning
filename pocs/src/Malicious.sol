// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract MaliciousContract{
    string public status = "Hacked! Address successfully hijacked!";

    function execute() external{}
}