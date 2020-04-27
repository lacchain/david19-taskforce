# Backend API

A backend will be responsible of getting the events form the contract, and then aggregate them and expose them trough API.

## CSV FORMAT API
The CSV format is required for ArcGis client.

|Column name  | Values types |Description |
|--|--|--|
|  type | cluster/point | cluster is an aggregation of a region and point is the raw credential |
|lat| integer| latitud |
|long|integer| longitud|
|usersCount|integer| Point:1 - Cluster: count of users by region|
|transactionCount|integer| Point: 1 - Cluster: count the number of credentials created|
|healthyCount|integer| Point: 1/0 - Cluster: count the healthy subjects. Is the number of credentials with no symptoms that subject is not infected or recovered|
|noSymptomsCount| integer| Point: 1/0 -  Cluster: count all the symptoms credential with **no** Symptoms|
|symptomsCount| integer| Point: 1/0 - Cluster: count one for each credential of Symptoms with at least one symptoms|
|feverCount|integer| Point: 1/0 - Cluster: count of each fever symptom|
|coughCount|integer| Point: 1/0 - Cluster: count of each cough symptom|
|breathingIssuesCount|integer| Point: 1/0 - Cluster: count of each breathing issues symptom|
|lossSmellCount|integer| Point: 1/0 - Cluster: count of each loss smell symptom|
|headacheCount|integer| Point: 1/0 - Cluster: count of each headache symptom|
|musclePainCount|integer| Point: 1/0 - Cluster: count of each muscle pain symptom|
|soreThroatCount|integer|Point: 1/0 - Cluster: count of each sore throat symptom|
|infectedCount|integer| Point: 1/0 - Cluster: count of each infected credential|
|recoveryCount|integer| Point: 1/0 - Cluster: count of each recovery credential|
|confinedCount|integer|Point: 1/0 - Cluster:  count of each confinement credential |
|confinementInterruptionCount|integer|Point: 1/0 - Cluster:  count of each confinement credential for 24hs since created. After the first 24hs is counted as a confinement credential |
|purchaseFoodCount|integer|Point: 1/0 - Cluster: count of each interruption of confinement because the person purchased food|
|workCount|integer|Point: 1/0 - Cluster: count of each interruption of confinement because the person went to work|
|medicinesCount|integer|Point: 1/0 - Cluster: count of each interruption of confinement because the person went to purchase medicines|
|doctorCount|integer|Point: 1/0 - Cluster: count of each interruption of confinement because the person went to the doctor|
|movingCount|integer|Point: 1/0 - Cluster: count of each interruption of confinement because the person moved form residence|
|assistCount|integer|Point: 1/0 - Cluster: count of each interruption of confinement because the person assisted another person in need|
|financialCount|integer|Point: 1/0 - Cluster: count of each interruption of confinement because the person went to the bank|
|forceCount|integer|Point: 1/0 - Cluster: count of each interruption of confinement because the person had a force majeure situation|
|petsCount|integer|Point: 1/0 - Cluster: count of each interruption of confinement because the person had to assist his pet |
|maleCount|integer| Point: 1/0 - Cluster:  count of each male counted|
|femaleCount|integer| Point: 1/0 - Cluster:  count of each female counted|
|otherSexCount|integer| Point: 1/0 - Cluster:  count of each other sex type counted|
|unspecifiedSexCount|integer| Point: 1/0 - Cluster:  count of each unspecified sex type counted|
|age|integer| Point: age of the user - Cluster: average of ages |
|form1318Count|integer| Point: 1/0 if the user is in the range - Cluster: count of users in the range of ages |
|form1930Count|integer| Point: 1/0 if the user is in the range - Cluster: count of users in the range of ages |
|form3140Count|integer| Point: 1/0 if the user is in the range - Cluster: count of users in the range of ages |
|form4165Count|integer| Point: 1/0 if the user is in the range - Cluster: count of users in the range of ages |
|form66Count|integer| Point: 1/0 if the user is in the range - Cluster: count of users in the range of ages |
|hash|string| Point: hash of the credential - Cluster: 0 |
|subjectId|string| Point: the HashId of the user - Cluster: 0|
