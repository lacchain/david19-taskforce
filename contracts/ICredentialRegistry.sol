pragma solidity ^0.6.0;

pragma experimental ABIEncoderV2;

interface ICredentialRegistry {
    enum CovidCode {
        Confinement,
        Interruption,
        Symptoms,
        Infection,
        Recovery
    }
    
    enum InterruptionReason {
        None,
        Purchase,
        AttendanceHealthCenter,
        CommutingWork,
        ReturnResidence,
        AssistPeople,
        CommutingFinancial,
        ForceMajeure
    }
    
    struct Location{
        bytes32 ubigeo;
        uint32 zipCode;
    }    

    struct CovidMetadata {
        bytes32 id;
        uint iat;
        uint exp;
        bool sex;
        uint8 age;
        Location location;
        CovidCode credentialType;
        InterruptionReason reason;
        bool status;
    }

    function register(bytes32 hash, bytes32 id, uint exp, bool sex, uint8 age, bytes32 location, uint32 zipcode, CovidCode credentialType, InterruptionReason reason) external returns (bool);
    
    function revoke(bytes32 hash) external returns (bool);
    
    function verify(bytes32 hash) external view returns (bool isValid);

    event CredentialRegistered(bytes32 indexed hash, address by, bytes32 id, uint iat, bool sex, uint8 age, CovidCode credentialType, InterruptionReason reason);
    event CredentialRevoked(bytes32 indexed hash, address by, uint256 date);
}