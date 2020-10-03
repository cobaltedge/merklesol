// efficient merkle trees
// TODO: precomputed hashes for lower depth
// TODO: test manual common subexpression elimination

pragma solidity ^0.6.7;

library Merkle {

    function getMerkleRoot(bytes[] memory elements, bytes32[256] storage defaults)
        internal view returns (bytes32) {

        // compute tree size
        uint pow2 = 1;
        uint depth = 0;
        while (pow2 < elements.length) {
            pow2 <<= 1;
            depth++;
        }

        // allocate working mem
        bytes32[] memory hashes = new bytes32[](pow2 / 2);

        // --- iterate pairwise over leaves ---

        bool odd = elements.length % 2 == 1;
        uint cap;
        if (odd) {
            cap = elements.length - 1;
        } else {
            cap = elements.length;
        }
        cap /= 2;

        for (uint i = 0; i < cap; i++) {
            hashes[i] = keccak256(abi.encodePacked(
                keccak256(elements[2 * i]) ,
                keccak256(elements[(2 * i) + 1])
            ));
        }

        uint resume;
        if (odd) {
            hashes[cap] = keccak256(abi.encodePacked(
                keccak256(elements[2 * cap]) ,
                defaults[0]
            ));
            resume = cap + 1;
        } else {
            resume = cap;
        }

        for (uint i = resume; i < pow2 / 2; i++) {
            hashes[i] = defaults[1];
        }

        // --- remaining nodes ---

        for (uint d = depth - 1; d > 0; d--) {
            for (uint i = 0; i < 2 ** (d - 1); i++) {
                hashes[i] = keccak256(abi.encodePacked(
                    hashes[2 * i] ,
                    hashes[(2 * i) + 1]
                ));
            }
        }

        return hashes[0];
    }

}
