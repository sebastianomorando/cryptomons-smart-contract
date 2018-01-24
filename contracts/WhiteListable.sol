pragma solidity ^0.4.4;
import 'zeppelin-solidity/contracts/lifecycle/Pausable.sol';

contract WhiteListable is Pausable {
    // list of all the contracts that can create new cryptomons
    mapping(address => bool) mintingWhitelist;

    modifier onlyWhitelistedForMinting() {
        require(mintingWhitelist[msg.sender] == true);
        _;
    }

    function enableMintingWhitelist(address _address) onlyOwner {
        mintingWhitelist[_address] = true;
    }

    function disableMintingWhitelist(address _address) onlyOwner {
        mintingWhitelist[_address] = false;
    }

    function isWhitelisted(address _address) {
        return mintingWhitelist[_address];
    }

}