pragma solidity ^0.6.7;

import "ds-test/test.sol";

import "./MerkleA.sol";
import "./MerkleB.sol";
import "./Lab.sol";

contract MerkleTest is DSTest {

    bytes32[256] defaults;
    bytes32[256] defaultsp;

    function setUp() external {
        bytes memory b;
        defaults[0] = keccak256(hex"");
        for (uint i = 1; i < 256; i++) {
            defaults[i] = keccak256(abi.encodePacked(
                defaults[i - 1] ,
                defaults[i - 1]
            ));
            bytes32 prev = defaultsp[i - 1];
            assembly {
                mstore(add(b, 32), prev)
                mstore(add(b, 64), prev)
            }
            defaultsp[i] = keccak256(b);
        }
    }

    // function test_root_correct2() external {
    //     bytes32[] memory data = new bytes32[](2);
    //     data[0] = keccak256(hex"11");
    //     data[1] = keccak256(hex"22");
    //     bytes32 r_ = keccak256(abi.encodePacked(
    //         data[0] ,
    //         data[1]
    //     ));
    //     bytes32 r = Merkle.getMerkleRoot(data, defaults);
    //     assertTrue(r == r_);
    // }

    // function test_root_correct3() external {
    //     bytes32[] memory data = new bytes32[](3);
    //     data[0] = keccak256(hex"11");
    //     data[1] = keccak256(hex"22");
    //     data[2] = keccak256(hex"33");
    //     bytes32 left = keccak256(abi.encodePacked(
    //         data[0] ,
    //         data[1]
    //     ));
    //     bytes32 right = keccak256(abi.encodePacked(
    //         data[2] ,
    //         keccak256(hex"")
    //     ));
    //     bytes32 r_ = keccak256(abi.encodePacked(
    //         left,
    //         right
    //     ));
    //     bytes32 r = Merkle.getMerkleRoot(data, defaults);
    //     assertTrue(r == r_);
    // }

    // function test_root_correct5() external {
    //     bytes32[] memory data = new bytes32[](5);
    //     data[0] = keccak256(hex"00");
    //     data[1] = keccak256(hex"11");
    //     data[2] = keccak256(hex"22");
    //     data[3] = keccak256(hex"33");
    //     data[4] = keccak256(hex"44");
    //     bytes32 r = keccak256(abi.encodePacked(
    //         keccak256(abi.encodePacked(
    //             keccak256(abi.encodePacked(data[0], data[1])),
    //             keccak256(abi.encodePacked(data[2], data[3]))
    //         )),
    //         keccak256(abi.encodePacked(
    //             keccak256(abi.encodePacked(data[4], defaults[0])),
    //             keccak256(abi.encodePacked(defaults[0], defaults[0]))
    //         ))
    //     ));
    //     assertTrue(Merkle.recursive(data, defaults) == r);
    //     assertTrue(Merkle.getMerkleRoot(data, defaults) == r);
    // }

    // function test_root_correct8() external {
    //     bytes32[] memory data = new bytes32[](8);
    //     data[0] = keccak256(hex"00");
    //     data[1] = keccak256(hex"11");
    //     data[2] = keccak256(hex"22");
    //     data[3] = keccak256(hex"33");
    //     data[4] = keccak256(hex"44");
    //     data[5] = keccak256(hex"55");
    //     data[6] = keccak256(hex"66");
    //     data[7] = keccak256(hex"77");
    //     bytes32 r = keccak256(abi.encodePacked(
    //         keccak256(abi.encodePacked(
    //             keccak256(abi.encodePacked(data[0], data[1])),
    //             keccak256(abi.encodePacked(data[2], data[3]))
    //         )),
    //         keccak256(abi.encodePacked(
    //             keccak256(abi.encodePacked(data[4], data[5])),
    //             keccak256(abi.encodePacked(data[6], data[7]))
    //         ))
    //     ));
    //     assertTrue(Merkle.recursive(data, defaults) == r);
    //     assertTrue(Merkle.getMerkleRoot(data, defaults) == r);
    // }

    // function test_recursive_gas4096() external {
    //     bytes32[] memory data = new bytes32[](4096);
    //     Merkle.recursive(data, defaults);
    // }

    // function test_gas4096() external {
    //     bytes32[] memory data = new bytes32[](4096);
    //     Merkle.getMerkleRoot(data, defaults);
    // }

    // function test_recursive_gas4097() external {
    //     bytes32[] memory data = new bytes32[](4097);
    //     Merkle.recursive(data, defaults);
    // }

    // function test_gas4097() external {
    //     bytes32[] memory data = new bytes32[](4097);
    //     Merkle.getMerkleRoot(data, defaults);
    // }

}
