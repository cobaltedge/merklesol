// efficient merkle trees
// TODO: test manual common subexpression elimination
// TODO: check .length cost

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

        bool odd = elements.length % 2 == 1;
        uint cap;
        if (odd) {
            cap = (elements.length - 1) / 2;
        } else {
            cap = elements.length / 2;
        }

        for (uint i = 0; i < cap; i++) {
            elements[i] = keccak256(abi.encodePacked(
                elements[2 * i    ] ,
                elements[2 * i + 1]
            ));
        }

        uint resume;
        if (odd) {
            elements[cap] = keccak256(abi.encodePacked(
                elements[2 * cap] ,
                defaults[0]
            ));
            resume = cap + 1;
        } else {
            resume = cap;
        }

        for (uint i = resume; i < pow2 / 2; i++) {
            elements[i] = defaults[1];
        }

        uint diff = (pow2 - elements.length) / 2;
        for (uint d = 2; d <= depth; d++) {
            uint d_ = depth - d;
            uint pow2_ = 2 ** d_;
            diff /= 2;
            uint midpoint = pow2_ - diff;

            for (uint i = 0; i < midpoint; i++) {
                elements[i] = keccak256(abi.encodePacked(
                    elements[2 * i    ] ,
                    elements[2 * i + 1]
                ));
            }
            for (uint i = midpoint; i < pow2_; i++) {
                elements[i] = defaults[d];
            }
        }

        return elements[0];
    }

}
