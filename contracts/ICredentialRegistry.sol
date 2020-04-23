pragma solidity ^0.5.0;

interface ICredentialRegistry {
    enum CovidCode {
        Confinement,
        Interruption,
        Symptoms,
        Infection,
        Recovery
    }
    
    enum InterruptionReason {
        Food,
        Work,
        Medicines,
        Doctor,
        Moving,
        Assist,
        Financial,
        Force,
        Pets, 
        Other
    }
    
    enum Sex{
        Male,
        Female,
        Unspecified,
        Other
    }    

    struct CovidMetadata {
        bytes32 subjectId;
        uint startDate;
        uint iat;
        uint exp;
        Sex sex;
        uint8 age;
        bytes6 geoHash;
        CovidCode credentialType;
        InterruptionReason reason;
        byte symptoms;
        bool status;
    }

    function register(bytes32 hash, bytes32 subjectId, uint startDate, uint exp,Sex sex, uint8 age, bytes6 geoHash, CovidCode credentialType, InterruptionReason reason, byte symptoms) external returns (bool);
    function revoke(bytes32 hash) external returns (bool);
    
    function verify(bytes32 hash, address citizen) external view returns (bool isValid);

    event CredentialRegistered(bytes32 indexed hash, address by, bytes32 id, uint startDate, uint iat, Sex sex, uint8 age, bytes6 geoHash, CovidCode credentialType, InterruptionReason reason, byte symptoms);
    event CredentialRevoked(bytes32 indexed hash, address by, uint256 date);
}