pragma solidity ^0.4.4;
import 'zeppelin-solidity/contracts/lifecycle/Pausable.sol';
import './Cryptomons.sol';
import './ValidDna.sol';

contract CryptoMonsMinting is Pausable, ValidDna {

    CryptoMons public nonFungibleContract;
    uint constant public sellingPrice = 0.01 ether;

    modifier minimum_value(uint256 x) {
        require(msg.value >= x);
        _;
    }

    function setNonFungibleContract(address _address) onlyOwner {
        nonFungibleContract = CryptoMons(_address);
    }

    function print(uint256 _tokenId)
    minimum_value(sellingPrice)
    payable
    {
        require(isValidDna(_tokenId));
        nonFungibleContract.mintAndTransfer(_tokenId, msg.sender);
    }

    function CryptoMonsMinting () {

    }
}