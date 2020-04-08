pragma solidity ^0.6.0;

import "@openzeppelin/contracts/access/roles/WhitelistedRole.sol";
import "./ICredentialRegistry.sol";

contract CovidCredentialRegistry is ICredentialRegistry, WhitelistedRole {

  mapping (bytes32 => mapping (address => CovidMetadata)) credentials;

  function register(bytes32 hash, bytes32 subjectId, uint startDate, uint exp, Sex sex, uint8 age, int16 latitude, int16 longitude, CovidCode credentialType, InterruptionReason reason) onlyWhitelisted override external returns(bool) {
    CovidMetadata storage credential = credentials[hash][msg.sender];
    require(credential.subjectId==0,"Credential ID already exists");

    credential.subjectId = subjectId;
    credential.startDate = startDate;
    credential.iat = now*1000;
    credential.exp = exp;
    credential.sex = sex;
    credential.age = age;
    credential.latitude = latitude;
    credential.longitude = longitude;
    credential.credentialType = credentialType;
    credential.reason = reason;
    credential.status = true;
    credentials[hash][msg.sender] = credential;
    emit CredentialRegistered(hash, msg.sender, subjectId, startDate, credential.iat, sex, latitude, longitude, credentialType, reason);
    return true;
  }

  function revoke(bytes32 hash) onlyWhitelisted override external returns(bool) {
    CovidMetadata storage credential = credentials[hash][msg.sender];

    require(credential.subjectId!=0, "credential hash doesn't exist");
    require(credential.status, "Credential is already revoked");  
     
    credential.status = false;  
    credentials[hash][msg.sender] = credential;
    emit CredentialRevoked(hash, msg.sender, now);
    return true;
  }
  
  function verify(bytes32 hash, address citizen) override external view returns(bool isValid){
    CovidMetadata memory credential = credentials[hash][citizen];
    require(credential.subjectId!=0,"Credential hash doesn't exist");
    return credential.status;
  }
  
  function latitudeLongitude(bytes32 hash, address citizen) external view returns (int16, int16){
      CovidMetadata memory credential = credentials[hash][citizen];
      return(credential.latitude, credential.longitude);
  } 
}