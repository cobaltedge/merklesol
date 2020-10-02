pragma solidity ^0.6.7;

import "ds-test/test.sol";

import "./Merkle.sol";

contract MerkleTest is DSTest {
    Merkle merkle;

    function setUp() public {
        merkle = new Merkle();
    }

    function testFail_basic_sanity() public {
        assertTrue(false);
    }

    function test_basic_sanity() public {
        assertTrue(true);
    }
}
