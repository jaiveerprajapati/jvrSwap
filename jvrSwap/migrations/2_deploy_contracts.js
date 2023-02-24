const JVRswap = artifacts.require("JVRswap");


module.exports = function(deployer, network, [owner]) {
 

  deployer.deploy(JVRswap, process.env.JVR_ERC_ADDRESS);
};
