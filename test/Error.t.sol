//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

import "forge-std/Test.sol";
import {Error} from "../src/Error.sol";

contract ErrorTest is Test {
    Error public err;

    function setUp() external {
        err = new Error();
    }

    function testThrowError() external {
        vm.expectRevert();
        err.throwError();
    }
    function testRequireMessage() external{
        vm.expectRevert(bytes("not authorized"));
        err.throwError();
    }
    function testCustomError() external{
        vm.expectRevert(Error.NotAuthorized.selector);
        err.throwCustomError();
    }
    function testErrorLable() public pure{
        assertEq(uint256(1), uint256(1), "test1");
        assertEq(uint256(1), uint256(1), "test2");
        assertEq(uint256(1), uint256(1), "test3");
        assertEq(uint256(1), uint256(1), "test4");
    }
        
}
