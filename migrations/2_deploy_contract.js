var Cryptomons = artifacts.require("../contracts/CryptoMons");

module.exports = function(deployer) {
  deployer.deploy(Cryptomons)
};