var Cryptomons = artifacts.require("../contracts/CryptoMons");
var MarketPlace = artifacts.require("../contracts/MarketPlace");
var CryptoMonsMinting = artifacts.require("../contracts/CryptoMonsMinting");

module.exports = function(deployer) {
  deployer.deploy(Cryptomons)
  deployer.deploy(MarketPlace)
  deployer.deploy(CryptoMonsMinting)
};