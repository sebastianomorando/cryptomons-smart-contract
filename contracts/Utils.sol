pragma solidity ^0.4.4;

contract Utils {
    /// convert un uint256 in a byte array
    function uintToByteArray(uint256 x) public returns (bytes b) {
        b = new bytes(32);
        for (uint i = 0; i < 32; i++) {
            b[i] = byte(uint8(x / (2**(8*(31 - i)))));
        }
    }

    function is_valid_dna(uint256 x) public returns (bool) {
        bytes memory b = uintToByteArray(x);
        if (b[31] >= 7) return false;
        if (b[31] < 7) return true;
    }
}