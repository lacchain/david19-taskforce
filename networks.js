const HDWalletProvider = require("@truffle/hdwallet-provider");
const privateKey = "<PRIVATE_KEY>";
const privateKeyProvider = new HDWalletProvider(privateKey, "http://<NODE>");

module.exports = {
  networks: {
    development: {
      protocol: 'http',
      host: 'localhost',
      port: 8545,
      gas: 8000000,
      gasPrice: 0,
      networkId: '*',
    },
    lacchain: {
      provider: privateKeyProvider,
      network_id: "648529",
      gasPrice: 0
    }
  },
};
