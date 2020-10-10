// efficient merkle trees
// TODO: test manual common subexpression elimination
// TODO: check .length cost

pragma solidity ^0.6.7;

library MerkleB {

    function recursive(bytes32[] memory elements, bytes32[256] storage defaults)
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

        if (size == 1) {
            if (li < elements.length) {
                return elements[li];
            } else {
                return defaults[0];
            }
        } else {

            if (li >= elements.length) {
                return defaults[depth];
            }

            uint size_ = size / 2;
            uint right_li = li + size_;
            return keccak256(abi.encodePacked(
                helper(elements, defaults, li, size_, depth - 1) ,
                helper(elements, defaults, right_li, size_, depth - 1)
            ));
        }

    }

}
