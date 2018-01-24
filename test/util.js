require("babel-polyfill");

const promisify = inner =>
  new Promise((resolve, reject) =>
    inner((err, res) => {
      if (err) {
        reject(err);
      }
      resolve(res);
    })
  );

// Took this from https://github.com/OpenZeppelin/zeppelin-solidity/blob/master/test/helpers/expectThrow.js
// Doesn't seem to work any more :(
// Changing to use the invalid opcode error instead works
const expectThrow = async promise => {
  try {
    await promise;
  } catch (err) {
    const outOfGas = err.message.includes("out of gas");
    const invalidOpcode = err.message.includes("invalid opcode");
    const revert = err.message.includes("revert");
    assert(
      outOfGas || invalidOpcode || revert,
      "Expected throw, got `" + err + "` instead"
    );
    return;
  }
  assert.fail("Expected throw not received");
};

const expectRevert = async promise => {
  try {
    await promise;
  } catch (err) {
    const revert = err.message.includes("revert");
    assert(
      revert,
      "Expected throw, got `" + err + "` instead"
    );
    return;
  }
  assert.fail("Expected throw not received");
}

// modified from: https://ethereum.stackexchange.com/questions/4027/how-do-you-get-the-balance-of-an-account-using-truffle-ether-pudding
const getBalance = async addr => {
  const res = await promisify(cb => web3.eth.getBalance(addr, cb));
  return new web3.BigNumber(res);
};

module.exports = {
  expectThrow,
  expectRevert,
  getBalance
};