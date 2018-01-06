pragma solidity ^0.4.4;
import 'zeppelin-solidity/contracts/lifecycle/Pausable.sol';

/*
    user approves the transfer of his token to the marketplace contract
*/

contract MarketPlace is Pausable {

    address public nonFungibleContract;
    uint256 public ownerCut;

    mapping (uint256 => uint256) public NFTForSale;

    function _owns(address _claimant, uint256 _tokenId) internal view returns (bool) {
        return (nonFungibleContract.ownerOf(_tokenId) == _claimant);
    }

    function _isForSale(uint256 _tokenId)  internal view returns (bool) {
        return (NFTForSale[_tokenId] != 0);
    }

    function _escrow(address _owner, uint256 _tokenId) internal {
        // it will throw if transfer fails
        nonFungibleContract.transferFrom(_owner, this, _tokenId);
    }

    function setNonFungibleContract(address _address) onlyOwner {
        nonFungibleContract = _address;
    }

    function putOnSale(uint256 _tokenId, uint256 price) {
        require(_owns(msg.sender, _tokenId));
        _escrow(msg.sender, _tokenId);
        NFTForSale[_tokenId] = price;
    }

    function _removeAuction(uint256 _tokenId) internal {
        delete tokenIdToAuction[_tokenId];
    }

    function buy(uint256 _tokenId)
    payable
    {
        require(_isForSale(_tokenId)); //check if it is for sale
        require(msg.value == NFTForSale[_tokenId]); //check if the price is equal to the sell price

        uint256 auctioneerCut = _computeCut(msg.value);
        uint256 sellerProceeds = msg.value - auctioneerCut;

        seller.transfer(sellerProceeds);

        //take the percentage and give the rest to the seller
        //transfer the token to the buyer
    }

    function _computeCut(uint256 _price) internal view returns (uint256) {
        return _price * ownerCut / 10000;
    }

}