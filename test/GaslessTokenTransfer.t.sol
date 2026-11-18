//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "forge-std/Test.sol";
import "forge-std/console.sol";

import "../src/GasLessTokenTransfer.sol";
import "../src/ERC20PermitTestToken.sol";

contract GasLessTokenTransferTest is Test{
    ERC20PermitTestToken private token; 
    GasLessTokenTransfer private gasless;

    uint256 constant SENDER_PRIVATE_KEY = 123;
    address sender;
    address receiver;
    uint constant AMOUNT = 1000;
    uint constant FEE = 10;

    function setUp() public {
        sender = vm.addr(SENDER_PRIVATE_KEY);
        receiver = address(2);
        token = new ERC20PermitTestToken("test token", "test");
        token.mint(sender, AMOUNT + FEE);
        gasless = new GasLessTokenTransfer();
    }

    function testValidSig() public {
        uint deadline = block.timestamp + 60;
        // prepare permit message
        bytes32 permithash = _getPermithash(
            sender,
            address(gasless),
            AMOUNT + FEE,
            token.nonces(sender),
            deadline
        );
         (uint8 v, bytes32 r, bytes32 s) = vm.sign(SENDER_PRIVATE_KEY, permithash);
            console2.log("--- Test Script Side ---");
            console2.log("Token:", address(token));
            console2.log("Sender (Owner):", sender);
            console2.log("Spender (Contract):", address(gasless));
            console2.log("Value (Amount + Fee):", AMOUNT + FEE);
            console2.log("Nonce:", token.nonces(sender));
            console2.log("Deadline:", deadline);
            console2.log("Permit Hash:", vm.toString(permithash));
        // Execute send
        gasless.send(
        address(token),
        sender,
        receiver,
        AMOUNT,
        FEE,
        deadline,
        v,  r,  s
        );
        // Check token balances
        assertEq(token.balanceOf(sender), 0, "sender balance");
        assertEq(token.balanceOf(receiver), AMOUNT, "receiver balance");
        assertEq(token.balanceOf(address(this)), FEE, "fee");
    }
    function _getPermithash(address owner, address spender, uint value, uint nonce, uint deadline) private view returns(bytes32){
        return keccak256(abi.encodePacked("\x19\x01", token.DOMAIN_SEPARATOR(), keccak256(abi.encode(
            keccak256("Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)"),
            owner,
            spender,
            value,
            nonce,
            deadline
        ))));
    }
}