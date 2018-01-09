pragma solidity ^0.4.4;
import 'zeppelin-solidity/contracts/lifecycle/Pausable.sol';

contract WhiteListable is Pausable {
    // list of all the contracts that can create new cryptomons
    mapping(address => bool) mintingWhitelist;

    // list of all the contracts that can buy and sell cryptomons
    mapping(address => bool) marketplaceWhitelist;

    modifier onlyWhitelistedForMinting() {
        require(mintingWhitelist[msg.sender] == true);
        _;
    }

    modifier onlyWhitelistedForMarketplace() {
        require(marketplaceWhitelist[msg.sender] == true);
        _;
    }

    function enableMintingWhitelist(address _address) onlyOwner {
        mintingWhitelist[_address] = true;
    }

    function disableMintingWhitelist(address _address) onlyOwner {
        mintingWhitelist[_address] = false;
    }

    function enableMarketplaceWhitelist(address _address) onlyOwner {
        marketplaceWhitelist[_address] = true;
    }

    function disableMarketplaceWhitelist(address _address) onlyOwner {
        marketplaceWhitelist[_address] = false;
    }
}