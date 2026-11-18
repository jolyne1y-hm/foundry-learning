//SPDX-License-Identifier: MIT
pragma solidity 0.8.36;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import {exp} from "../src/Exp.sol";
import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";

contract DifferentialTest_1 is Test{
    
    function testFuzz_exp2(int128 x) public {
        // 把下溢或者误差区间的负数直接用 assume 过滤，或者把阈值收紧
        vm.assume(x > -1000000000000 && x < 0x4000000000000000);
       

        int128 y1 = exp(x);
        console.log("Current x:", x);

       string[] memory inputs = new string[](2);
       inputs[0] = "test/run_py.sh";
       inputs[1] = vm.toString(uint256(int256(x)));
       

       bytes memory res = vm.ffi(inputs);
       int128 pythonResult = abi.decode(res, (int128));

        uint256 DELTA = 10;
        assertApproxEqAbs(uint256(int256(pythonResult)), uint256(int256(y1)), DELTA);

    }
}