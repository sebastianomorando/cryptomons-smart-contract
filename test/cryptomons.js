const CryptoMons = artifacts.require("CryptoMons");
const MarketPlace = artifacts.require("marketPlace");
const CryptoMonsMinting = artifacts.require("CryptoMonsMinting");
const util = require("./util.js");

contract('CryptoMonsMinting', async function (accounts) {
  const core = await CryptoMons.deployed()
  const minting = await CryptoMonsMinting.deployed()
  const owner = accounts[0]
  const user1 = accounts[1]
  const user2 = accounts[2]
  const user3 = accounts[3]

  it("should assign the minting contract to the non fungible one", async function () {
    await minting.NonFungibleContract(core.address)
    let address = await minting.NonFungibleContractAddress.call()
    assert.equal(core.address, address, "Contract assignment not done")
  })

  it("should wehitelist the minting contract and let a user to print his own cryptomon card", async function () {
    await core.enableMintingWhitelist(minting.address)
    await minting.print(core.address, (5, {from: user1}))
    let newOwner = await core.ownerOf(5)
    assert.equal(user1, newOwner, "Token not assigned to buyer")
  })

})

contract('MarketPlace', async function (accounts){
  const core = await CryptoMons.deployed()
  const mp = await MarketPlace.deployed()
  const owner = accounts[0]
  const user1 = accounts[1]
  const user2 = accounts[2]
  const user3 = accounts[3]

  it("should assign the marketplace contract to the non fungible one", async function () {
    await mp.NonFungibleContract(core.address)
    let address = await mp.NonFungibleContractAddress.call()
    assert.equal(core.address, address, "Contract assignement not done")
  })

  it("should not be possible to get a cryptomon by the core contract", async function () {
    await core.takeOwnership(5, {from: user1})
    let newOwner = await core.ownerOf(5)
    assert.equal(user1, newOwner, "Token not assigned to buyer")
  })

})

contract('CryptoMons', (accounts) => {
  const owner = accounts[0]
  const user1 = accounts[1]
  const user2 = accounts[2]
  const user3 = accounts[3]
  // var contract
  it("should assign a cryptomon to a buyer", function () {
    return CryptoMons.deployed().then((instance) => {
      contract = instance
      return instance.buy(5, {from: user1, value: web3.toWei('0.01', 'ether')})
    }).then((result) => {
      return contract.ownerOf.call(5)
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
