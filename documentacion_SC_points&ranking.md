# Documentation of the smart contract for points and level registration

This document aims to provide documentation for smart contract [LevelPointsRegistry](https://github.com/lacchain/DAVID19-taskforce/blob/master/contracts/LevelPointsRegistry.sol).

## What is this smart contract for?

This smart contract will serve as a public database to store points and level information self-attested by citizens related to the Coronavirus. The citizens will be able to use different apps/wallets to attest [that information](https://github.com/lacchain/DAVID19-taskforce/tree/master/docs). 

Summarizing, this smart contract allows to register, verify the level and points balance of a citizen 

Use cases

* Set quantity of points and level a citizen

* Externap services will consume the information from the smart contract.

* Any organization or user can verify the level and quantity of points a citizen.

## Components

### ILevelPointsRegistry 

It is an interface which defines following enums:

**CovidCode**
```
enum Level{
        CommittedCitizen,
        HeroPromise,
        HeroApprentice,
        Hero,
        HeroMaster,
        David19
}
```
which handles the different levels of david19.

**Citizen**
```
struct Citizen {
        uint256 points;
        Level level;
}
```
This struct will save metadata related the level and points a citizen(user).

* points: 
* level: 

### WhiteListedRole

This contract manages the whitelist roles. Any organization registered can whitelist new user address. This contract is an implementation from [WhitelistedRole Openzeppelin](https://docs.openzeppelin.com/contracts/2.x/api/access#WhitelistedRole).

### LevelPointsRegistry

This contract implements the ILevelPointsRegistry interface and inherits WhiteListedRoles methods.

**Add Address Whitelisted**

`function addWhitelisted(address account) public onlyWhitelistAdmin`

This function will be executed by the organizations that have previously been assigned the role to add new addresses to the whitelist.

* address: Is a citizen(user) or organization address.

**SetPoints and Level**

`function setPoints(bytes32 subjectId, uint256 points, Level level) external returns (bool)`

This function set points and level. 

we get out the subjectId field from the credentialSubject object, remove the white spaces, order fields alphabetically (a-z) and finally put the values in capital letters. For example for this case, the object from which we would generate the hash, would be like this:
```json
"credentialSubject":{"birthDate":"YYYY","confinement":{"geo":{"latitude":"-12.04","longitude":"77.08"},"numberOfParticipants":4,"startDate":"2020-03-01T19:23:24Z"},"familyName":["PAREJA","ABARCA"],"givenName":"ADRIAN","nickName":"CCAMALEON","sameAs":"URN:PE:DNI:23434343","sex":"MALE"}
```
Finally to obtain the hash use the algorithm sha-256, which would be:
F094F56522F9EAD2305CB4B2BC84B12409556AC76F613E2448EBE320C3CDA947

The rest of parameters are explained in [`Citizen struct`](#ilevelpointsregistry) section.

For example, the parameters to register a covid credential could be:

* subjectId: 0x93FA3E4624676F2E9AA143911118B4547087E9B6E0B6076F2E1027D7A2DA2B0A
* points: 100
* sex: Level.Hero (value:3)

The requirements for the points to be registered are that: 

* the address that sends the transaction is whitelisted by any organization and that the credential does not exist.

In order to be able to do so, the organization that wishes to be whitelisted can reach out to info@lacchain.net.

## Deploy and Upgrade Smart Contract

We are using [Openzeppelin Cli](https://docs.openzeppelin.com/cli/2.8/) to deploy the upgradable smart contract.

First, you need to install openzeppelin cli dependencies. 

```$ npm install --save-dev @openzeppelin/cli```

Second, you need to modify the networks.js file to set the node and private key to deploy the smart contract. Next execute the command to deploy. 

```$ npx openzeppelin deploy```

If you need to upgrade the smart contract then execute the following command.

`npx openzeppelin upgrade`

## Test the Smart Contract 

ONLY TEST - Upgradable LevelPoints Smart Contract on Covid-Network - TEST --> 0x73Cd0FD17390F81701329210b3296E9Da4165Ed3

PRODUCTION - LevelPoints Registyry on Covid Network --> 0x60ea04D698EB386534826410D7dF0969f567aA01