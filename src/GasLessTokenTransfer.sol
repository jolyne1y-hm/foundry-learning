//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {IERC20Permit} from "@openzeppelin/contracts/token/ERC20/extensions/IERC20Permit.sol";
import "forge-std/console2.sol";
import "forge-std/Test.sol";

contract GasLessTokenTransfer is Test{
    function send(
        address token,
        address sender,
        address receiver,
        uint amount,
        uint fee,
       uint256 deadline,
       uint8 v, bytes32 r, bytes32 s
    ) external  {
        // 需要先在业务合约里 import "forge-std/Test.sol"; 或者用 console2
            console2.log("--- Contract Side ---");
            console2.log("Token:", token);
            console2.log("Sender:", sender);
            console2.log("Spender:", address(this));
            console2.log("Value:", amount + fee);
            console2.log("Deadline:", deadline);
            console2.log("v:", v);
// 字节类型可以用 vm.toString 打印
            console2.log("r:", vm.toString(r));
            console2.log("s:", vm.toString(s));
    IERC20Permit(token).permit(
        sender,
        address(this),
        amount + fee,
       deadline,
         v, r, s 
         );// permit -- sender approves this contract to spend amount + fee
    IERC20Permit(token).transferFrom(sender, receiver, amount);// tranferFrom (sender, receiver, amount)
    IERC20Permit(token).transferFrom(sender, msg.sender, fee); // transferFrom (sender, msg.sender, fee)
    }
}