pragma solidity ^0.4.4;
import 'zeppelin-solidity/contracts/lifecycle/Pausable.sol';
import './Utils.sol';
import './CryptoMonsOwnership.sol';

contract CryptoMons is Pausable, Utils, CryptoMonsOwnership {

    uint constant public sellingPrice = 0.01 ether;

    // 0: for sale, 1: not for sale
    uint8[16] public cryptoMonState;

    modifier minimum_value(uint256 x) {
        require(msg.value >= x);
        _;
    }

    //claim a cryptomon
    function takeOwnership(uint256 _tokenId) {
        cryptoMonIndexToAddress[_tokenId] = msg.sender;
        balanceOf[msg.sender]++;
    }

    //get all cryptomons state
    function getAllCryptoMonState() public returns (uint8[16]) {
        return cryptoMonState;
    }

    function buy(uint256 _tokenId)
    minimum_value(sellingPrice)
    payable
    {
        require(ownerOf(_tokenId) == address(0));
        cryptoMonIndexToAddress[_tokenId] = msg.sender;
        _balanceOf[msg.sender]++;
    }

    function CryptoMons() {

    }
}