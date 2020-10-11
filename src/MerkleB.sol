// efficient merkle trees
// TODO: test manual common subexpression elimination
// TODO: check .length cost

pragma solidity ^0.6.7;

library MerkleB {

    function getMerkleRoot(bytes32[] memory elements, bytes32[256] storage defaults)
        internal view returns (bytes32) {

        // compute tree depth
        uint pow2 = 1;
        uint depth = 0;
        while (pow2 < elements.length) {
            pow2 <<= 1;
            depth++;
        }

        return helper(elements, defaults, 0, pow2, depth);
    }

    function helper(
        bytes32[] memory elements,
        bytes32[256] storage defaults,
        uint li,
        uint size,
        uint depth)

        internal view returns (bytes32) {

        if (size != 1) {
            if (li >= elements.length) {
                return defaults[depth];
            } else {
                uint size_ = size / 2;
                bytes32 left = helper(elements, defaults, li, size_, depth - 1);
                bytes32 right = helper(elements, defaults, li + size_, size_, depth - 1);
                bytes memory buf; // don't need to allocate?
                assembly {
                    mstore(add(buf, 32), left)
                    mstore(add(buf, 64), right)
                }
                return keccak256(buf);
            }
        } else {
            if (li >= elements.length) {
                return defaults[0];
            } else {
                return elements[li];
            }
        }
    }

}
