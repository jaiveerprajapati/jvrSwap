const HDWalletProvider = require("truffle-hdwallet-provider-privkey");
require("dotenv").config();

module.exports = {
  networks: {
    ropsten: {
      provider: () =>
        new HDWalletProvider(
          [process.env.PK],
          `https://ropsten.infura.io/v3/${process.env.INFURA_KEY}`
        ),
      network_id: 3,
      skipDryRun: true
    }
  },

  compilers: {
    solc: {
      version: "0.5.7",
      docker: false,
      settings: {
        optimizer: {
          enabled: true,
          runs: 200
        }
      }
    }
  }
};
