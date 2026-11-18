//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

//  Topics
// - Invariant
// - Difference between fuzz and invariant
// - Failing invariant tests
// - Passing invariant tests
// - Stats - runs, calls, reverts

contract IntroInvariant {
    bool public flag;

    function fun_1() external{}
    function fun_2() external{}
    function fun_3() external{}
    function fun_4() external{}
    function fun_5() external{
        flag = true;
    }
}

import "forge-std/Test.sol";

contract IntroInvariantTest is Test{
    IntroInvariant private target;

    function setUp() public{
        target = new IntroInvariant();
    }
    
    function invariant_flag_is_always_false() public view{
        assertEq(target.flag(), false);
    }
}