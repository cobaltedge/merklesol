// efficient merkle trees
// TODO: manual common subexpression elimination

pragma solidity ^0.6.7;

library MerkleA {

    function getMerkleRoot(bytes32[] memory elements, bytes32[256] storage defaults)
        internal view returns (bytes32) {

        // compute tree depth
        uint pow2 = 1;
        uint depth = 0;
        while (pow2 < elements.length) {
            pow2 <<= 1;
            depth++;
        }

        bytes memory buf = new bytes(64);
        bytes32 left; bytes32 right;

        for (uint i = 0; i < elements.length / 2; i++) {
            left  = elements[2 * i    ];
            right = elements[2 * i + 1];
            assembly {
                mstore(add(buf, 32), left)
                mstore(add(buf, 64), right)
            }
            elements[i] = keccak256(buf);
        }

        for (uint i = elements.length; i < pow2 >> 1; i++) {
            elements[i] = defaults[1];
        }

        uint diff = (pow2 - elements.length) / 2;
        uint pow2_ = pow2 >> 1;
        for (uint d = 2; d <= depth; d++) {
            pow2_ >>= 1;
            diff  /= 2;
            uint midpoint = pow2_ - diff;

            for (uint i = 0; i < midpoint; i++) {
                left  = elements[2 * i    ];
                right = elements[2 * i + 1];
                assembly {
                    mstore(add(buf, 32), left)
                    mstore(add(buf, 64), right)
                }
                elements[i] = keccak256(buf);
            }

            for (uint i = midpoint; i < pow2_; i++) {
                elements[i] = defaults[d];
            }
        }

        return elements[0];
    }

}
