pragma solidity ^0.4.4;
import 'zeppelin-solidity/contracts/lifecycle/Pausable.sol';
import './Utils.sol';
import './CryptoMonsOwnership.sol';

contract CryptoMons is Pausable, Utils, CryptoMonsOwnership, WhiteListable {

    function changeMetadataBaseUrl(string _baseUrl) onlyOwner {
        baseUrl = _baseUrl;
    }

    function assignName(uint256 _tokenId, string name)
    {
        require(msg.sender == ownerOf(_tokenId));
        require(bytes(cryptoMonName[_tokenId]).length == 0);
        cryptoMonName[_tokenId] = name;
    }

    function mint(uint256 _tokenId)
    onlyWhitelistedForMinting()
    {
        mintAndTransfer(_tokenId, msg.sender);
    }

    function mintAndTransfer(uint256 _tokenId, address _address)
    onlyWhitelistedForMinting()
    {
        require(ownerOf(_tokenId) == address(0));
        cryptoMonIndexToAddress[_tokenId] = _address;
        _balanceOf[_address]++;
        _totalSupply++;
    }

    function CryptoMons() {

    }
}