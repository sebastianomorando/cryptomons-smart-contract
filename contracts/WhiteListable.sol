pragma solidity ^0.4.4;

contract WhiteListable {
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

    function enableMintingWhitelist(address _address) {
        mintingWhitelist[_address] = true;
    }

    function disableMintingWhitelist(address _address){
        mintingWhitelist[_address] = false;
    }

    function enableMarketplaceWhitelist(address _address) {
        marketplaceWhitelist[_address] = true;
    }

    function disableMarketplaceWhitelist(address _address){
        marketplaceWhitelist[_address] = false;
    }
}