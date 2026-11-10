// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import  "forge-std/Test.sol";
import  "../src/HelloWorld.sol";

contract HelloWorldTest is Test {
    HelloWorld public helloWorld;

    function setUp() public {
        helloWorld = new HelloWorld();
      
    }

    function testGreet() view public {
        helloWorld.greet();
        assertEq(helloWorld.greet(),
        "Hello World!");
    }

 
}
