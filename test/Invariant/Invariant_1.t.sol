//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import {WETH} from "../../src/WETH.sol";

// NOTE: open testing - randomly call all public functions
contract WETH_Open_Invariant_Tests is Test{
    WETH public weth;

    function setUp() public {
        weth = new WETH();
    }

    function invariant_totalSupply_equals_ether_balance() public view{
        assertEq(weth.totalSupply(), address(weth).balance);
    }
}