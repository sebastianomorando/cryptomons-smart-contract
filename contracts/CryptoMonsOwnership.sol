pragma solidity ^0.4.4;

import 'zeppelin-solidity/contracts/lifecycle/Pausable.sol';
import "./ERC721Draft.sol";
import "./CryptoMonsBase.sol";
import "./WhiteListable.sol";
import "./Utils.sol";

contract CryptoMonsOwnership is CryptoMonsBase, ERC721, Pausable, Utils {

    string public name = "CryptoMons";
    string public symbol = "CM";

    function implementsERC721() public pure returns (bool)
    {
        return true;
    }

    function _owns(address _claimant, uint256 _tokenId) internal view returns (bool) {
        return (ownerOf(_tokenId) == _claimant);
    }

    function _approvedFor(address _claimant, uint256 _tokenId) internal view returns (bool) {
        return cryptoMonIndexToApproved[_tokenId] == _claimant;
    }

    function _approve(uint256 _tokenId, address _approved) internal {
        cryptoMonIndexToApproved[_tokenId] = _approved;
    }

    function _transfer(address _from, address _to, uint256 _tokenId) internal {
        cryptoMonIndexToAddress[_tokenId] = _to;
        _balanceOf[_from]--;
        _balanceOf[_to]++;
        Transfer(_from, _to, _tokenId);
    }

    function balanceOf(address _owner) public view returns (uint256) {
        return _balanceOf[_owner];
    }

    function totalSupply() public view returns (uint) {
        return _totalSupply;
    }

    function ownerOf(uint256 _tokenId) public view returns (address) {
        return cryptoMonIndexToAddress[_tokenId];
    }

    function approve(address _to, uint256 _tokenId) public whenNotPaused {
        require(_owns(msg.sender, _tokenId));
        cryptoMonIndexToApproved[_tokenId] = _to;
        Approval(msg.sender, _to, _tokenId);
    }

    function transferFrom(address _from, address _to, uint256 _tokenId) public whenNotPaused {
        require(_approvedFor(_to, _tokenId));
        _transfer(_from, _to, _tokenId);
    }

    function transfer(address _to, uint256 _tokenId) public whenNotPaused {
        transferFrom(msg.sender, _to, _tokenId);
    }

    /*
    function tokenMetadata(uint256 _tokenId) public view returns (string) {
        return strConcat(baseUrl, uintToBytes(_tokenId));
    }
*/
    function CryptoMonsOwnership () {

    }
}