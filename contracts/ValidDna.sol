pragma solidity ^0.4.4;

import 'zeppelin-solidity/contracts/ownership/Ownable.sol';
import "./Utils.sol";

contract ValidDna is Utils, Ownable {

  uint8[32] public validDnaValues;

  function setValidDnaValues(uint8[32] _validDnaValues) onlyOwner {
    validDnaValues = _validDnaValues;
  }

  function isValidDna(uint256 x) public returns (bool) {
    uint8[32] memory b = uintToByteArray(x);
    for (uint index = 0; index < 32; index++) {
      if (b[index] > validDnaValues[index]) return false;
    }
    return true;
  }

    function ValidDna () {
        validDnaValues = [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,5, 6, 11, 11, 11, 11 ];
    }
}