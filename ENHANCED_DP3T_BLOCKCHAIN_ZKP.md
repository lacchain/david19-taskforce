# Enhanced DP3T contact tracing using blockchain and zero-knowledge proofs 

In this article we present a fully decentralized approach for contact tracing that gets ride of a central back-end/server and eliminates all the risks associated to it. This solution allows:

* Alice to notify Bob that she has been tested positive directly (in a peer-to-peer way), without no intermediary central back-end/server
* Alice to prove Bob that she has been tested positive by a trusted health institution without revealing ANY information about it (the institution, the place, the timestamp, …)
* Alice to prove Bob that she has been in contact with him in the past 14 days without revealing the specific information about that contact. These includes not even disclosing her pseudonymous identifier or the specific timestamp of the contact. This prevents Bob to know Bob to know who she really is even if he was able to discover who the person behind an identifier he was in contact with is

In the past months we have seen different solutions to fight the spread of the COVID-19 in the form of tracing apps that use the Bluetooth of personal mobile phones. Two of these have already been acknowledged as very effective in Singapur and South Korea. However, these apps have also raised some concerns around data privacy. Apple and Google are working together to release a [privacy preserving contact tracing solution](https://www.apple.com/covid19/contacttracing). In parallel, a joint effort of several doctors and professors from several European universities released and have been updating a proposal called [Decentralized Privacy-Preserving Proximity Tracing (DP-3T)](https://github.com/DP-3T/documents). This is one of the projects under the umbrella of the [Pan-European Privacy-Preserving Proximity Tracing (PEPP-PT)]( https://www.pepp-pt.org/
) collaboration.

All of these solutions have in common many things:

* The use of Bluetooth technology as the most precise way of contact tracing, as an opposition to the GPS.  

* A government and/or a health institution behind it.

* Citizens are identified with pseudonymous identifiers (in more privacy preserving solutions each person has rotating identifiers)

* When an individual is closer to a person than a certain threshold (of a few meters), the mobile app registers locally the pseudonymous identifier of the person he or she has been closed to, and the timestamp of the contact

* There is a central back-end/server maintained by the central institution behind the solution that is connected to all the mobile phones using the app.

These solutions also have differences. One of the most relevant consists on how much information the central entity has. This leads to the current classification into centralized and decentralized solutions that can be defined as follows:

**Centralized:** The central entity behind the solution that controls the back-end/server generates the identifiers to the users, knows who is the real person behind the identifier, and has access to non-anonymous and precise data about who is healthy, who is infected, and who has been in contact with whom.

**Decentralized:** Citizens generate their own pseudonymous and random identifiers and never reveal it to the entity behind the solution that controls the back-end/server. Citizens send to the back-end/server, controlled by the central entity, information about who have they been in contact with and the timestamp of the contact, and a notification when they are tested positive. The real identities of the individuals are hidden to the central back-end/server behind the pseudonymous identifiers, that can also be rotated with a certain frequency.

## Limitations of central components for decentralized solutions

Introducing central components in decentralized solutions is a common roadblock that many applications are facing these days. Decentralized protocols are still emerging, and it is not easy to design and implement a solution that is fully decentralized with no central elements. 

In the cases being developed and presented in the previous section, both centralized and decentralized (in fact semi-decentralized) approaches face privacy limitations. The DP-3T project has done a very thorough job in identifying and listing this [privacy issues](https://github.com/DP-3T/documents/blob/master/Security%20analysis/Privacy%20and%20Security%20Attacks%20on%20Digital%20Proximity%20Tracing%20Systems.pdf). We believe that all these issues, or at least most of them, no longer appear in a totally decentralized solution that do not requires the central back-end/server that focalizes most of the issues as is a single point of failure and eavesdropping.

Some of the issues that cannot be easily suppressed when we use a central back-end/server are:

* As the central server stores information about our location and/or contacts, a good algorithm could be able to infer who we are. Therefore, the pseudonymous information can easily become personal identifiable information (PII). 
* The previous can be minimized by generating new pseudonymous identifiers very often for the same individual. However, stablishing correlations from the centralized database is also plausible, because it is still possible to determine a common identity between different identifiers. First, because if Alice is using different identifiers while being in a prolonged contact with Bob and Charlie but Bob and Charlie are using the same identifiers (respectively) during that time, then it can be infer that those different identifiers belonging to Alice belong to Alice.
* The previous can also be minimized by collecting only information of infected people. Even in this case, infected people can be easily discovered. In all the scenarios they always have to notify that all the identifiers they have been using for at least the past two weeks are infected, as well as all the identifiers they where in touch with, so the server can notify them. 
* The data in the back-end/server can be modified or deleted both by the entity in charge of the management or by a hacker. In any case, it will not be impossible to prove so, as the original data (the non-anonymous data) is only in the mobile phones, and it will be impossible to reconstruct the truth from a well fabricated lie.
* If a malicious Alice is in contact with Bob and Alice is checking the new pseudonymous identifiers registered in her app, Alice can easily stablish the connection between Bob’s identifier and Bob’s real identity. Alice can then disclose this information publicly. 
* In the most privacy-preserving apps that rotate IDs very often and perform other calculations in the app, storage and computational capabilities required can become not negligible.

The central entity behind the solution that controls the back-end/server generates the identifiers to the users, knows who is the real person behind the identifier, and has access to non-anonymous and precise data about who is healthy, who is infected, and who has been in contact with whom.

## Full decentralized contact tracing using blockchain and zero-knowledge proofs 

We believe that replacing the central back-end/server by a decentralized immutable and trusted network can help solve most of the privacy issues presented in the DP-3T approach and pointed out by its development team. Additionally, adding zero-knowledge proofs to the peer-to-peer communication between mobile apps when notifying infection can also contribute to reduce the discovery of the real identities of infected people. This solution is intended to allow:

* Alice to notify Bob that she has been tested positive directly (in a peer-to-peer way), without no intermediary central back-end/server
* Alice to prove Bob that she has been tested positive by a trusted health institution without revealing ANY information about it (the institution, the place, the timestamp, …)
* Alice to prove Bob that she has been in contact with him in the past 14 days without revealing ANY information about that contact. These includes not even disclosing her pseudonymous identifier or the timestamp of the contact. This prevents Bob to know Bob to know who she really is even if he was able to discover who the person behind an identifier he was in contact with is.

The solution is as follows:

1.	We can use the same algorithms to generate and rotate the ephemeral IDs (EphIDs) proposed by the DP3T team.
2.	After the generation of each EphID, the mobile app creates a DID document (following the W3C standard Decentralized Identifiers (DIDs)) and registers it in a public blockchain ledger. A DID document is a resource that allows to resolve the EphID, by indicating the public keys and an endpoint associated to it. The DID document shall not reveal any personal information of the person behind the pseudonymous EphID.
3.	Using the Bluetooth technology well described in all the previously mentioned proposals, every individual records in their mobile apps the information about which identifiers have they been in touch with and at what time (the timestamps).
4.	Every time an individual is tested positive by a health institution, this institution generates a verifiable credential (following the W3C standard Verifiable Credentials (VCs)) digitally signed and sends it to the individual. At the same time, this entity registers the hash of this credential in a public smart contract that this entity controls (only it has permissions to write on it) together with the timestamp and the status of the credential (so if this institution revokes it, the hash will be shown in the smart contract with status revoked).
5.	When an individual receives this credential of positive test, it automatically reaches out to all the individuals it has been in contact with for the past (at least) two weeks. In order to do so, the mobile app retrieves all the EphIDs registered in the local database it has been in touched with, goes to the blockchain, and resolves their endpoints.
6.	In order for a tested-positive person to notify he or she 

7.	these other individuals that they have been in touch with a positive tested individual but without disclosing who did the tests or what is the pseudonymous so privacy can be fully preserved, the infected individual sends two zero-knowledge-proofs:
a.	A proof that they have a credential signed by a trusted authorized health institution.
b.	A proof that they have been in touch with the person they are reaching out to.

Steps number 5 and 6 are not trivial and they require further explanation. We break them down in the next sections.

## Peer-to-peer communication 

There are different ways to achieve peer-to-peer between individuals.

Endpoints could be simple URLs. A blockchain-based approach (using Ethereum technology) is the [whisper protocol]( https://github.com/ethereum/wiki/wiki/Whisper). This allows peer-to-peer communication between Dapps. A third approach could be using a smart contract as the endpoint. The sender could send the information there encripted with the recipient´s public keys.

As endpoints are public, we need to ensure that nobody is spammed with millions of trash messages to his/her endpoint. This can be done by requiring a proof of work in order to be able to send a message to an individual’s endpoint.

[This scenarios requiere non-interactive zero-knowledge proofs as there is not a bi-directional communication between the two peers, only one-directional message]


## Zero knowledge proofs

The first zero-knowledge proof requires Alice to proof to Bob that she has been tested positive by a trusted entity. The trusted entity registered (in step 4) the hash of the verifiable credential issued to Alice in the public smart contract, with its status. Only Alice has that verifiable credential, so all Alice needs to do is proving that she has the payload of that hash without showing it. This problem can be put as “proving knowledge of a hash pre-image” and is a [solved problem]( https://blog.decentriq.ch/proving-hash-pre-image-zksnarks-zokrates/
).

The second proof requires Alice to proof Bob that she has been in contact with him without revealing her pseudonymous identifier. In order to do so, Alice can tell Bob the time and place where they were in contact, but reducing the precision of this information (a more range of time and place generated with the original plus a certain random error). With this we intend Alice to be able to prove Bob with enough degree of confidence that she knew were he was, which she could know because she was also there, but at the same time not revealing who of all the people that was also there she was. So the more crowded the area where Bob was at that time, the broader the list of candidates he can make to meet Alice information. [This second proof in not a zero-knowledge proof, according to the definition of these. In the case that Bob was not close to any other people at the time he contacted Alice, he could know who Alice’s pseudonymous identifier is (in the case that Bob is a tech-savvy that can check the back-end of his mobile app’s database) and therefore, if Bob can discover Alice’s identity behind that identifier, Bob will know that the real identity of Alice is infected. However, we believe that only in the cases where Bob and Alice are well-known people that spend time alone this will happen. In those cases, Bob would probable get to know directly from Alice that she is infected. However, alternatives to this proof are welcome.]

---

***Thanks to Adrian Pareja, Diego Leon, Antonio Leal, and David Ammouial for their insights.***
