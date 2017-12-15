const CryptoMons = artifacts.require("CryptoMons");
const util = require("./util.js");

contract('CryptoMons', (accounts) => {
  const owner = accounts[0]
  const user1 = accounts[1]
  const user2 = accounts[2]
  const user3 = accounts[3]
  var contract
  it("should assign a cryptomon to a buyer", function () {
    return CryptoMons.deployed().then((instance) => {
      contract = instance
      return instance.buy(5, {from: user1, value: web3.toWei('0.01', 'ether')})
    }).then((result) => {
      return contract.GetOwnerOf.call(5)
    }).then((result) => {
      assert.equal(user1, result, "Token not assigned to buyer")
    })
  })

  it("should not assign the cryptomon if the buyer doesn't send enough ether", async function() {
    await util.expectThrow(
      contract.buy(6, {from: user1, value: web3.toWei('0.001', 'ether')})
    );
  })

  it("should not assign the cryptomon if it's already owned by another player", async function () {
    await util.expectThrow(
      contract.buy(5, {from: user2, value: web3.toWei('0.01', 'ether')})
    )
  })
})
