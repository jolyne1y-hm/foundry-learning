//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "forge-std/Test.sol";
import "forge-std/console.sol";

interface IWETH {
    function balanceOf(address) external view returns(uint256);
    function deposit() external payable;
}

contract ForkTest is Test{
    IWETH public weth;

    function setUp() public{
        weth = IWETH(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);
    }

    function testWeth() public{ 
        uint256 mainnetId = vm.createFork("mainnet");
        vm.selectFork(mainnetId);
        // uint balBefore = weth.balanceOf(address(this));
        address randomUser = address(0x9999999999999999999999999999999999999999);
        console.log("clean user bal before:", weth.balanceOf(randomUser)); 
        // console.lob("balance before", balBefore);
        vm.deal(randomUser, 1 ether);
        vm.prank(randomUser);

        weth.deposit{value: 100}();
        // uint balAfter = weth.balanceOf(address(this));
        console.log("randomUser balance after",weth.balanceOf(randomUser));
        // console.log("balance after", balAfter);
    }
}