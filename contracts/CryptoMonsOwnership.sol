pragma solidity ^0.4.4;

import "./ERC721Draft.sol";
import "./CryptoMonsBase.sol";

contract CryptoMonsOwnership is CryptoMonsBase, ERC721 {

    string public name = "CryptoMons";
    string public symbol = "CM";

    function implementsERC721() public pure returns (bool)
    {
        return true;
    }

    function totalSupply() public view returns (uint) {
        return _totalSupply;
    }

    function balanceOf(address _owner) public view returns (uint256) {
        return _balanceOf[_owner];
    }

    function ownerOf(uint256 _tokenId) public view returns (address) {
        return cryptoMonIndexToAddress[_tokenId];
    }

    function approve(address _to, uint256 _tokenId) public WhenNotPaused {
        require(_owns(msg.sender, _tokenId));
        cryptoMonIndexToApproved[_tokenId] = _to;
    }

    function transferFrom(address _from, address _to, uint256 _tokenId) public WhenNotPaused {

    }

    function transfer(address _to, uint256 _tokenId) public {

    }

    function CryptoMonsOwnership () {

    }
}