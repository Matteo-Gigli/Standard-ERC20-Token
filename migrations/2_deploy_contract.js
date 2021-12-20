const newToken = artifacts.require("newToken");

module.exports = function (deployer) {
  const totalAmount = web3.utils.toWei('100', 'ether')
  deployer.deploy(newToken, 'MyToken', 'MTT', totalAmount, 18);
};