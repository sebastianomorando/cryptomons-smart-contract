pragma solidity ^0.4.4;
import 'zeppelin-solidity/contracts/lifecycle/Pausable.sol';
import 'zeppelin-solidity/contracts/math/SafeMath.sol';
import './Utils.sol';
import './CryptoMonsOwnership.sol';

contract CryptoMons is Pausable, Utils, CryptoMonsOwnership, WhiteListable {
    using SafeMath for uint256;

    event Minted(address indexed newOwner, uint256 indexed tokenId);

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
        uint256 length = balanceOf(_address);
        _assetsOf[_address].push(_tokenId);
        _indexOfAsset[_tokenId] = length;
        cryptoMonIndexToAddress[_tokenId] = _address;
        _balanceOf[_address]++;
        _totalSupply++;
        Minted(_address, _tokenId);
    }

    function _removeAssetFrom(address from, uint256 _tokenId) internal {
        uint256 assetIndex = _indexOfAsset[_tokenId];
        uint256 lastAssetIndex = _assetsOf[from].length;
        uint256 lastAssetId = _assetsOf[from][lastAssetIndex];

        cryptoMonIndexToAddress[_tokenId] = 0;

        // Insert the last asset into the position previously occupied by the asset to be removed
        _assetsOf[from][assetIndex] = lastAssetId;

        // Resize the array
        _assetsOf[from][lastAssetIndex] = 0;
        _assetsOf[from].length--;

        // Remove the array if no more assets are owned to prevent pollution
        if (_assetsOf[from].length == 0) {
            delete _assetsOf[from];
        }

        // Update the index of positions for the asset
        _indexOfAsset[_tokenId] = 0;
        _indexOfAsset[lastAssetId] = assetIndex;

    }

    function assetsOf(address holder) external view returns (uint256[]) {
        return _assetsOf[holder];
    }

    function CryptoMons() {

    }
}