# Smart Contract Documentation
This document aims to provide documentation for smart contract [CovidCredentialRegistry](https://github.com/lacchain/DAVID19-taskforce/blob/master/contracts/CovidCredentialRegistry.sol).

## What is this smart contract for?
It's a mechanism for verifiable credentials wallets register, revoke and verify a verifiable credential and metadata related to citizen from a country. 

Use cases
* Verifiable credentials Wallets allow users register theyself their Covid verifiable credentials.

* Wallets allow users revoke theyself their Covid verifiable credentials.

* Any organization or user can verify if the credential is valid.

## Components

### ICredentialRegistry 

Is an interface which defines following enums:

**CovidCode**
```
enum CovidCode {
        Confinement,
        Interruption,
        Symptoms,
        Infection,
        Recovery
}
```
which handles the different types of covid credentials.

**InterruptionReason**
```
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
```
Which handles reasons for a confinement interruption form.

Also, there are structs defined:

**Location**
```
struct Location{
        string ubigeo;
        uint16 zipCode;
} 
```
This struct is used to register a citizen location
* ubigeo: This field is composed for 4 parts. First part for country, using [ISO 3166](https://www.iso.org/iso-3166-country-codes.html) to describe with 3 letters the country. Second part to describe the state of the country. Third part to describe the city of the state and the last part to describe a neighborhood. All parts separated by ':'.

    For example to describe the neighborhood Lince located in Lima-Peru, it will be PER:LIMA:LIMA:LINCE = 0x5045524c494d304c494e43453030303030303030303030303030303030303030 

* zipcode: Field to know more precisely the location of a citizen.

    For example a zipcode can be 15073 to determine my location

**CovidMetadata**
```
struct CovidMetadata {
        bytes32 id;
        uint startDate;
        uint iat;
        uint exp;
        bool sex;
        uint8 age;
        Location location;
        CovidCode credentialType;
        InterruptionReason reason;
        bool status;
}
```
This struct will save metadata related the verifiable credential and the citizen(user) who register the covid verifiable credential.

* id: is an unique citizen(user) identifier. For Example: 0x93FA3E4624676F2E9AA143911118B4547087E9B6E0B6076F2E1027D7A2DA2B0A
* startDate: datetime in milliseconds when the citizen started your confinement, happened an interruption, etc.
* iat: the timestamp in milliseconds when the credential is issued. For example: 123456
* exp: the timestamp in milliseconds when the credential expires. For example: 124000
* sex: male or female (true or false). For example true for male.
* age: age of the citizen. For example 35
* location: the Location Struct wich is detailed above.
* credentialType: the CovidCode enum which is detailed above.
* reason: the InterruptionReason wich is detailed above.
* status: The state of the credential. true for valid and false for invalid. 

### WhiteListedRole

This contract manage the whitelist roles. Any organization registered can whitelist new user address. This contract is an implementation from [WhitelistedRole Openzeppelin](https://docs.openzeppelin.com/contracts/2.x/api/access#WhitelistedRole).

### CovidCredentialRegistry

This contract implements the ICredentialRegistry interface and inherits WhiteListedRoles methods.

**Add Address Whitelisted**

`function addWhitelisted(address account) public onlyWhitelistAdmin`

This function will be executed by the organizations that have previously been assigned the role to add new addresses to the whitelist.

* address: Is a citizen(user) or organization address.

**Register covid credential**

`function register(bytes32 hash, bytes32 id, uint startDate, uint exp, bool sex, uint8 age, bytes32 ubigeo, uint32 zipcode, CovidCode credentialType, InterruptionReason reason) override external returns(bool)`

This function register a new covid credential and metadata from a whitelisted address. 

* hash: this parameter is the hash of the verifiable credential.

the rest of parameters are explained in [`CovidMetadata struct`](###ICredentialRegistry) section.

For example, the parameters to register a covid credential could be:

* hash: 0x7A906FA6137E4325646E8F8814C4F719345D50C1BB056FCF78A2A031A6A584E0
* id: 0x93FA3E4624676F2E9AA143911118B4547087E9B6E0B6076F2E1027D7A2DA2B0A
* startDate: 1586571297000 (Sat Apr 11 2020 02:14:57 UTC)
* exp: 1586771297000 (Mon Apr 13 2020 09:48:17 UTC)
* sex: True
* age: 35
* ubigeo: 0x5045524c494d304c494e43453030303030303030303030303030303030303030
* credentialType: CovidCode.Confinement
* reason: InterruptionReason.None

the requirements for the credential to be registered are that: 
* the address that sends the transaction is whitelisted by any organization and that the credential does not exist.

**Revoke covid credential**

`
function revoke(bytes32 hash) override external returns(bool)
`

This function revoke a covid credential previously registered

* hash: this parameter is the hash of the verifiable credential that will be revoked.

the requirements for the credential to be revoked are that: 
* only the same address that registered the credential can revoke it (the credential exists) and that the credential is in a valid state.

**Verify a credential**

`
function verify(bytes32 hash, address citizen) override external view returns(bool isValid)
`

This function verify if a credential is valid.

* hash: this parameter is the hash of the verifiable credential that will be verified.
* citizen: address of a citizen who generated the credential.