pragma solidity ^0.4.4;

import "./ERC721Draft.sol";

contract CryptoMonsOwnership is ERC721 {

    string public name = "CryptoMons";
    string public symbol = "CM";

    function implementsERC721() public pure returns (bool)
    {
        return true;
    }

    function CryptoMonsOwnership () {

    }
}