pragma solidity ^0.4.4;
import 'zeppelin-solidity/contracts/lifecycle/Pausable.sol';

contract MarketPlace is Pausable {
    address public NonFungibleContractAddress;

    function NonFungibleContract(address _address) onlyOwner {
        NonFungibleContractAddress = _address;
    }
}