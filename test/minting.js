const CryptoMons = artifacts.require("CryptoMons");
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
    await minting.setNonFungibleContract(core.address)
    let address = await minting.nonFungibleContract.call()
    assert.equal(core.address, address, "Contract assignment not done")
  })

  it("should wehitelist the minting contract and let a user to print his own cryptomon card", async function () {
    await core.enableMintingWhitelist(minting.address)
    await minting.print(5, {from: user1, value: web3.toWei('0.01', 'ether')})
    let newOwner = await core.ownerOf(5)
    assert.equal(user1, newOwner, "Token not assigned to buyer")
  })

})