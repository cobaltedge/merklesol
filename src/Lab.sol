pragma solidity ^0.6.7;

library Lab {

    function encodepacked() internal {
        bytes32 a = hex"11";
        bytes32 b = hex"22";
        bytes memory bs = new bytes(64);
        bytes32 r = keccak256(abi.encodePacked(a, b));

    }

    function concat() internal {
        bytes32 a = hex"11";
        bytes32 b = hex"22";
        bytes memory r = new bytes(64);
        assembly {
            mstore(add(r, 32), a)
            mstore(add(r, 64), b)
        }
        bytes32 r_ = keccak256(r);
    }

    function pusha() internal returns (bytes32) {
        return hex"11";
    }
    function pushb(bytes32 b) internal returns (bytes32) {
        return hex"11";
    }

}
