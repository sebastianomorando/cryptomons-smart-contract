pragma solidity ^0.4.4;
import 'zeppelin-solidity/contracts/ownership/Ownable.sol';

contract CryptoMons is Ownable{

    uint constant public sellingPrice = 0.01 ether;

    // 0: for sale, 1: not for sale
    uint8[16] public cryptoMonState;

    // map a monster to an address
    mapping (uint256 => address) public cryptoMonIndexToAddress;

    mapping (address => uint256) public AddressToCryptoMonIndex;

    /* This creates an array with all balances */
    mapping (address => uint256) public balanceOf;

    modifier minimum_value(uint256 x) {
        require(msg.value >= x);
        _;
    }

    /// convert un uint256 in a byte array
    function uintToByteArray(uint256 x) public returns (bytes b) {
        b = new bytes(32);
        for (uint i = 0; i < 32; i++) {
            b[i] = byte(uint8(x / (2**(8*(31 - i)))));
        }
    }

    function is_valid_dna(uint256 x) public returns (bool) {
        bytes memory b = uintToByteArray(x);
        if (b[31] >= 7) return false;
        if (b[31] < 7) return true;
    }

    function ownerOf(uint256 _tokenId) public returns (address) {
        return cryptoMonIndexToAddress[_tokenId];
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
        balanceOf[msg.sender]++;
    }

    function CryptoMons() {

    }
}