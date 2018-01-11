const CryptoMons = artifacts.require("CryptoMons");
const MarketPlace = artifacts.require("marketPlace");
const CryptoMonsMinting = artifacts.require("CryptoMonsMinting");
const util = require("./util.js");

contract('CryptoMonsMinting', async function (accounts) {
  const owner = accounts[0]
  const user1 = accounts[1]
  const user2 = accounts[2]
  const user3 = accounts[3]

  it("should convert a uint256 to a uint8[32]", async function () {
    const core = await CryptoMons.deployed()
    const minting = await CryptoMonsMinting.deployed()
    let validDnaValues = await minting.validDnaValues.call(31)
    let result = await minting.uintToByteArray.call(1)
    console.log(validDnaValues.toString())
    //console.log(result)
    assert.equal(result[31], 1, "Error in conversion")
  })

  it("should assign the minting contract to the non fungible one", async function () {
    const core = await CryptoMons.deployed()
    const minting = await CryptoMonsMinting.deployed()
    await minting.setNonFungibleContract(core.address)
    let ownerBalance =  await util.getBalance(owner)
    let gasCost = web3.toWei('100', 'ether') - ownerBalance
    console.log('GAS COST TO DEPLOY CONTRACTS', gasCost)
    let address = await minting.nonFungibleContract.call()
    assert.equal(core.address, address, "Contract assignment not done")
  })

  it("should whitelist the minting contract and let a user to print his own cryptomon card", async function () {
    const core = await CryptoMons.deployed()
    const minting = await CryptoMonsMinting.deployed()
    await core.enableMintingWhitelist(minting.address)
    let before = await util.getBalance(user1)
    await minting.print(5, {from: user1, value: web3.toWei('0.01', 'ether')})
    let after = await util.getBalance(user1)
    let gasCost = before - after
    console.log('GAS COST FOR THE TRANSACTION:', gasCost)
    let newOwner = await core.ownerOf(5)
    console.log(newOwner)
    assert.equal(user1, newOwner, "Token not assigned to buyer")
  })

  it("should not let print cards under the minimum value", async function () {
    const minting = await CryptoMonsMinting.deployed()
    await util.expectThrow(
      minting.print(8, {from: user1, value: web3.toWei('0.001', 'ether')})
    )
  })
  
  it("should not print cards already printed", async function () {
    const minting = await CryptoMonsMinting.deployed()
    await util.expectThrow(
      minting.print(5, {from: user2, value: web3.toWei('0.01', 'ether')})
    )
  })

  it ("should return the correct total supply", async function () {
    const core = await CryptoMons.deployed()
    let existingMons = await core.totalSupply()
    assert.equal(existingMons, 2)
  })

})

/*contract('MarketPlace', async function (accounts){
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

})*/

contract('CryptoMons', async function (accounts) {
  const core = await CryptoMons.deployed()
  const owner = accounts[0]
  const user1 = accounts[1]
  const user2 = accounts[2]
  const user3 = accounts[3]
  // var contract
  it("should let a whitelisted address mint cryptomons", async function () {
      await core.enableMintingWhitelist(owner)
      await core.mintAndTransfer(6, user1)
      let newOwner = await core.ownerOf(6)
      assert.equal(user1, newOwner, "Token not assigned to buyer")
    })

  it ("should not let a not whitelisted address mint cryptomons", async function () {
    await util.expectThrow(
      core.mintAndTransfer(7, user1, {from: user1})
    );
  })

  it ("should return the correct total supply", async function () {
    let existingMons = await core.totalSupply()
    assert.equal(existingMons, 1)
  })

})
