pragma solidity ^0.4.4;

contract CryptoMonsBase {

    uint public _totalSupply = 0;

    // base url for the metadata
    string public baseUrl = 'http://api.cryptomons.com/png?dna=';

    // map a monster to an address
    mapping (uint256 => address) public cryptoMonIndexToAddress;

    mapping (address => uint256) public AddressToCryptoMonIndex;

    mapping (uint256 => address) public cryptoMonIndexToApproved;

    mapping (uint256 => string) public cryptoMonName;

    /* This creates an array with all balances */
    mapping (address => uint256) public _balanceOf;

    function CryptoMonsBase() {

    }
}