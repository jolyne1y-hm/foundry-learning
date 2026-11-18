//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

import "forge-std/Test.sol";

contract SignTest is Test{
    // private key = 123
    // public key = vm.addr(private key)
    // message = "secret message"
    // message hash = keccak256(message)
    // vm.sign (private key, message hash)
    function testSignature() public pure {
        uint256 privatekey = 123;
        address pubKey = vm.addr(privatekey);
        bytes32 messagehash = keccak256("Sercret Message");
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(privatekey, messagehash);

        address signer = ecrecover(messagehash, v, r, s);
        assertEq(signer, pubKey);

        bytes32 InvalidMessageHash = keccak256("Invalid Message");
        signer = ecrecover(InvalidMessageHash, v, r, s);
        assertTrue(signer != pubKey);
    }
}