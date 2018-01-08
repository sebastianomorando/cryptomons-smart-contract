pragma solidity ^0.4.4;
import 'zeppelin-solidity/contracts/lifecycle/Pausable.sol';

contract CryptoMonsMinting is Pausable {

    address public nonFungibleContract;
    uint constant public sellingPrice = 0.01 ether;

    modifier minimum_value(uint256 x) {
        require(msg.value >= x);
        _;
    }

    function setNonFungibleContract(address _address) onlyOwner {
        nonFungibleContract = _address;
    }

    function print(uint256 _tokenId)
    minimum_value(sellingPrice)
    payable
    {
        nonFungibleContract.mintAndTransfer(_tokenId, msg.sender);
    }

    function CryptoMonsMinting () {

    }
}