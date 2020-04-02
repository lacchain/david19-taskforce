pragma solidity ^0.6.0;

import "@openzeppelin/contracts/access/roles/WhitelistedRole.sol";
import "./ICredentialRegistry.sol";

contract CovidCredentialRegistry is ICredentialRegistry, WhitelistedRole {

  mapping (bytes32 => mapping (address => CovidMetadata)) credentials;

  function register(bytes32 hash, bytes32 id, uint startDate, uint exp, Sex sex, uint8 age, string calldata ubigeo, uint32 zipcode, CovidCode credentialType, InterruptionReason reason) onlyWhitelisted override external returns(bool) {
    CovidMetadata storage credential = credentials[hash][msg.sender];
    require(credential.id==0,"Credential ID already exists");

    credential.id = id;
    credential.startDate = startDate;
    credential.iat = now*1000;
    credential.exp = exp;
    credential.sex = sex;
    credential.age = age;
    credential.ubigeo = ubigeo;
    credential.zipcode = zipcode;
    credential.credentialType = credentialType;
    credential.reason = reason;
    credential.status = true;
    credentials[hash][msg.sender] = credential;
    emit CredentialRegistered(hash, msg.sender, id, startDate, credential.iat, sex, ubigeo, zipcode, credentialType, reason);
    return true;
  }

  function revoke(bytes32 hash) onlyWhitelisted override external returns(bool) {
    CovidMetadata storage credential = credentials[hash][msg.sender];

    require(credential.id!=0, "credential hash doesn't exist");
    require(credential.status, "Credential is already revoked");  
     
    credential.status = false;  
    credentials[hash][msg.sender] = credential;
    emit CredentialRevoked(hash, msg.sender, now);
    return true;
  }
  
  function verify(bytes32 hash, address citizen) override external view returns(bool isValid){
    CovidMetadata memory credential = credentials[hash][citizen];
    require(credential.id!=0,"Credential hash doesn't exist");
    return credential.status;
  }
}