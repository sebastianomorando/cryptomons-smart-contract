pragma solidity ^0.4.4;

contract Utils {

    /// convert un uint256 in a byte array
    function uintToByteArray (uint _tokenId) /*internal*/ returns (uint8[32] b) {
        for (uint i = 0; i < 32; i++) {
            b[i] = uint8(_tokenId / (2**(8*(31 - i))));
        }
        return b;
    }

    // taken from https://github.com/pipermerriam/ethereum-string-utils/blob/master/contracts/StringLib.sol
    function uintToBytes(uint v) constant returns (bytes32 ret) {
        if (v == 0) {
            ret = '0';
        }
        else {
            while (v > 0) {
                ret = bytes32(uint(ret) / (2 ** 8));
                ret |= bytes32(((v % 10) + 48) * 2 ** (8 * 31));
                v /= 10;
            }
        }
        return ret;
    }

    // taken from https://github.com/oraclize/ethereum-api/blob/master/oraclizeAPI_0.5.sol
    function strConcat(string _a, string _b) internal pure returns (string) {
        bytes memory _ba = bytes(_a);
        bytes memory _bb = bytes(_b);
        string memory abcde = new string(_ba.length + _bb.length);
        bytes memory babcde = bytes(abcde);
        uint k = 0;
        for (uint i = 0; i < _ba.length; i++) babcde[k++] = _ba[i];
        for (i = 0; i < _bb.length; i++) babcde[k++] = _bb[i];
        return string(babcde);
    }
}