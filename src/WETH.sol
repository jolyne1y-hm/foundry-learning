// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract WETH is ERC20("Wrapped Ether", "WETH") {
    event Deposit(address indexed account, uint amount);
    event Withdraw(address indexed account, uint amount);

    // 1. 存款包装：ETH -> WETH
    function deposit() public payable {
        _mint(msg.sender, msg.value);
        emit Deposit(msg.sender, msg.value);
    }

    // 2. 兜底函数：直接转入 ETH 时自动触发封装
    receive() external payable {
        deposit();
    }

    // 3. 提现解包：WETH -> ETH
    function withdraw(uint amount) external {
        // 第一步：先销毁用户的 WETH（防重入核心）
        _burn(msg.sender, amount);

        // 第二步：使用 .call 将原生 ETH 安全转回给用户
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "ETH transfer failed");

        emit Withdraw(msg.sender, amount);
    }
}