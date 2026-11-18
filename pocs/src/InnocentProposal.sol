// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract InnocentProposal{
    function execute() external{
        selfdestruct(payable(msg.sender));
    }
}