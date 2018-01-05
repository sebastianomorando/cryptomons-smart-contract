var Cryptomons = artifacts.require("../contracts/CryptoMons");
var MarketPlace = artifacts.require("../contracts/MarketPlace");

module.exports = function(deployer) {
  deployer.deploy(Cryptomons)
  deployer.deploy(MarketPlace)
};