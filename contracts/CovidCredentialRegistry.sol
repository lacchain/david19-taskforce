pragma solidity ^0.6.0;

import "@openzeppelin/contracts/access/roles/WhitelistedRole.sol";
import "./ICredentialRegistry.sol";

contract CovidCredentialRegistry is ICredentialRegistry, WhitelistedRole {

  mapping (bytes32 => mapping (address => CovidMetadata)) credentials;

  function register(bytes32 hash, bytes32 id, uint exp, bool sex, uint8 age, bytes32 ubigeo, uint32 zipcode, CovidCode credentialType, InterruptionReason reason) override external returns(bool) {
    require(super.isWhitelisted(msg.sender), "Account isn't whitelisted");
    CovidMetadata storage credential = credentials[hash][msg.sender];
    require(credential.id==0,"Credential ID already exists");

    credential.id = id;
    credential.iat = now;
    credential.exp = exp;
    credential.sex = sex;
    credential.age = age;
    Location memory location = Location(ubigeo,zipcode);
    credential.location = location;
    credential.credentialType = credentialType;
    credential.reason = reason;
    credential.status = true;
    credentials[hash][msg.sender] = credential;
    emit CredentialRegistered(hash, msg.sender, id, now, sex, age, credentialType, reason);
    return true;
  }

  function revoke(bytes32 hash) override external returns(bool) {
    require(super.isWhitelisted(msg.sender), "Account isn't whitelisted");  
    CovidMetadata storage credential = credentials[hash][msg.sender];

    require(credential.id!=0, "credential hash doesn't exist");
    require(credential.status, "Credential is already revoked");  
     
    credential.status = false;  
    credentials[hash][msg.sender] = credential;
    emit CredentialRevoked(hash, msg.sender, now);
    return true;
  }
  
  function verify(bytes32 hash) override external view returns(bool isValid){
    CovidMetadata memory credential = credentials[hash][msg.sender];
    require(credential.id!=0,"Credential hash doesn't exist");
    return credential.status;
  }
}