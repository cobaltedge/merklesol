pragma solidity ^0.6.7;

import "ds-test/test.sol";

import "./Merkle.sol";

contract MerkleTest is DSTest {

    bytes32[256] defaults;

    function setUp() external {
        defaults[0] = keccak256(hex"");
        defaults[1] = keccak256(abi.encodePacked(
            defaults[0] ,
            defaults[0]
        ));
    }

    function test_root_correctA() external {
        bytes[] memory data = new bytes[](2);
        data[0] = hex"11";
        data[1] = hex"22";
        bytes32 r_ = keccak256(abi.encodePacked(
            keccak256(data[0]) ,
            keccak256(data[1])
        ));
        bytes32 r = Merkle.getMerkleRoot(data, defaults);
        assertTrue(r == r_);
    }

    function test_root_correctB() external {
        bytes[] memory data = new bytes[](3);
        data[0] = hex"11";
        data[1] = hex"22";
        data[2] = hex"33";
        bytes32 left = keccak256(abi.encodePacked(
            keccak256(data[0]) ,
            keccak256(data[1])
        ));
        bytes32 right = keccak256(abi.encodePacked(
            keccak256(data[2]) ,
            keccak256(hex"")
        ));
        bytes32 r_ = keccak256(abi.encodePacked(
            left,
            right
        ));
        bytes32 r = Merkle.getMerkleRoot(data, defaults);
        assertTrue(r == r_);
    }

}
