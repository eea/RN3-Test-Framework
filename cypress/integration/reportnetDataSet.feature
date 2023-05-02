Feature: Reportnet Dataset - As an existing user on the Repornet system I want to test the actions with dataset data

@sanity

Scenario: a) As a data custodian I can add a new data flow with obligations

Given I'm logged at Reportnet page as 'userCustodian'
And the "action" "Create new dataflow" is "be.visible"
Then  I "Create" a reporting dataflow with name "Dataset Reportnet Testing" and description "Dataflow dataset test" and obligation "(C) Information on the assessment regime (Article 7)" with "noFilters"


@sanity 
Scenario: b) As a data custodian I can create new dataset schema

Given I'm logged at Reportnet page as 'userCustodian'
And I click on "Dataset Reportnet Testing"
And I can click on element "New schema"
And I can create a dataset schema public available with name "DS-Test"
And Confirm new dataset schema creation is visible
Then I can click on element "DS-Test"
Then I can go to the list dataflows page
And I click on "Dataset Reportnet Testing"
And I can click on element "New schema"
And I can create a dataset schema public available with name "DS2"
And Confirm new dataset schema creation is visible


@sanity
Scenario: c) As a data custodian I can fill a dataset schema

Given I'm logged at Reportnet page as 'userCustodian'
And I click on "Dataset Reportnet Testing"
And I can click on element "DS-Test"
Then I can fill a dataset schema with name "Table1", description "description Table1" and with following fields
 | Field1 | Field 1 description | Number - Integer | | true |
 | Field2 | Field 2 description | Text             | |      |
 And I can go to the list dataflows page
And I click on "Dataset Reportnet Testing"
And I can click on element "DS2"
Then I can fill a dataset schema with name "T1", description "description T1" and with following fields
 | f1 | Field 1 description | Number - Integer | | true |
 | f2 | Field 2 description | Text             | |      |
 And I can go to the list dataflows page
And I click on "Dataset Reportnet Testing"
And I can click on element "DS-Test"
Then I can fill a dataset schema with name "Table4", description "description Table4" and with following fields
 | Field1 | Field 1 description | Number - Integer | | false | true |
And I mark the table as a "prefilled"
And I mark the table as a "fixed number of records"
And I change to "Tabular data" mode
And I can add a record 
|1| |


@sanity
Scenario: d) As a data custodian I can add a Data provider

Given I'm logged at Reportnet page as 'userCustodian'
And I click on "Dataset Reportnet Testing"
And I can click on element "Manage lead reporters"
Then I can "add" a Data provider with Representative of "EEA Member countries" and account "test.provider@abc.com" and Data provider "Spain"
And I can click on element "Manage lead reporters"
And I can see the representative "Spain" "test.provider@abc.com"


@sanity
Scenario: e) As a data custodian I can create new field constraint QC Rules

Given I'm logged at Reportnet page as 'userCustodian'
And I click on "Dataset Reportnet Testing"
And I can click on element "DS-Test"
When the "button" "QC rules" is "be.visible"
Then I can "create" the field constraint rule with fields
| Table1 | Field1 | blocker Test | testName | Field type NUMBER | Message Info | Blocker |
And I can "Create" a "Field comparison" with a "" with fields
 | false  | AND | Number | <= | 100  |
And I can filter QCs by "levelError" with "BLOCKER"
And the code rule "blocker Test" is "be.visible" on the list of rules


@sanity
Scenario: f) As a data custodian I can create data collections

Given I'm logged at Reportnet page as 'userCustodian'
And I click on "Dataset Reportnet Testing"
And I can click on element "Create data collections"
Then I can create data collections with a technical acceptance step for the reporter submissions and "public"
And I see the message: "SUCCESS"


#REP-943
@sanity
Scenario: g) As a data provider I can't release to data collection if blockers in any dataset

Given I'm logged at Reportnet page as 'userProvider'
When I filter the dataflow list by "name" with "Dataset Reportnet Testing"
And I click on "Dataset Reportnet Testing"
And I can click on element "DS-Test"
And I can add a record
    | 101 |  |
And the "action" "Dataflows" is "be.visible"
And I click on "Dataset Reportnet Testing"
When I can click on element "Release to data collection"
And I can confirm release to data collection with "no restrict to public"
And I see the message: "ERROR"
And I see the message: "You can't release data with blocker errors. Please check it and try again."


#REP-822
Scenario: h) As a reporter, I can see the status of the dataset in the title

Given I'm logged at Reportnet page as 'userProvider'
When I filter the dataflow list by "name" with "Dataset Reportnet Testing"
And I click on "Dataset Reportnet Testing"
And I can click on element "DS-Test"
Then I see the message: "Pending"


#REP-2160
@ignore
Scenario: i) Add data to dataset with Import

Given I'm logged at Reportnet page as 'userProvider'
When I filter the dataflow list by "name" with "Dataset Reportnet Testing"
And I click on "Dataset Reportnet Testing"
And I can click on element "DS-Test"
And the "button" "Import table data" is "be.enabled"
And I import a file "test.csv"
Then I see the message: "SUCCESS"


#REP-943
Scenario: j) As a LEAD REPORTER, I want to release data with validations passed.

Given I'm logged at Reportnet page as 'userProvider'
When I filter the dataflow list by "name" with "Dataset Reportnet Testing"
And I click on "Dataset Reportnet Testing"
And I can click on element "DS2"
And I can add a record
    | 101 |  |
And I can go to the dataflow page
And I can click on element "DS-Test"
And the "button" "Import table data" is "be.enabled"
And I import a file "test.csv"
Then I see the message: "SUCCESS"
And I reload the page
And I can go to the dataflow page
When I can click on element "Release to data collection"
And I can confirm release to data collection with "no restrict to public"
And I see the message SUCCESS RELEASE TO DATA COLLECTION


#REP-1817
Scenario: k) In the public page I can see the automatically created export file if the dataset was set to public during the data release

Given I'm in Reportnet page
And I can click on "View by obligation dataflow"
And I "can" see the publicly dataflow "Dataset Reportnet Testing"
When I click on "Dataset Reportnet Testing"
Then the public table "Reporting datasets" has 1 records
And I'm logged at Reportnet page as 'userCustodian'


# REP-1432
Scenario Outline: l) As a public user I can see the list of all dataflows marked as publicly available

Given I'm in Reportnet page
And I can click on "View by obligation dataflow"
Then I "can" see the publicly dataflow "Dataset Reportnet Testing"
And I can see for dataflow "Dataset Reportnet Testing" the instrument "Air Quality Directive IPR", status "Open"
And I can see the information on "Dataset Reportnet Testing" with "<country>" "<type>" "<technicalAcceptance>"
And I'm logged at Reportnet page as 'userCustodian'

 Examples: 
    | country            | type                 | technicalAcceptance |
    | Spain              | technical acceptance | Final feedback      |


#REP-822 #REP-1669 #REP-2284
Scenario: m) As a custodian, I can see the manual technical acceptance dialogue

Given I'm logged at Reportnet page as 'userCustodian'
When I filter the dataflow list by "name" with "Dataset Reportnet Testing"
And I click on "Dataset Reportnet Testing"
And I can click on element "Manual technical acceptance"
When I see the datasets with manual technical acceptance for dataflow "Dataset Reportnet Testing"
Then I can change the dataset "Spain" to status "Technically accepted" and message "status changed"
And I can see the dataset "Spain" with status "Technically accepted"
And I can click on element "Technical feedback"
And I select the country "Spain"
And I can see the message received "status changed"
And the "action" "Notifications" is "be.visible"
Then I see the notification "DS-Test changed to Technically accepted" in the notification received list


#REP-873 #REP-1771
Scenario: o) As a data custodian I can see the historic releases

Given I'm logged at Reportnet page as 'userCustodian'
When I filter the dataflow list by "name" with "Dataset Reportnet Testing"
And I click on "Dataset Reportnet Testing"
And I click in a button "Historic releases" inside "Data Collection - DS-Test" context menu
Then the table "Historic releases for Data Collection - DS-Test" has 1 records
And I click in a button "Historic releases" inside "Data Collection - DS-Test" context menu
And I can click on the link to be redirected to another page
And the table "Table1" has 2 records


#REP-2160
Scenario: p) Validate button is enabled for data Provider

Given I'm logged at Reportnet page as 'userProvider'
When I filter the dataflow list by "name" with "Dataset Reportnet Testing"
And I click on "Dataset Reportnet Testing"
And I can click on element "DS-Test"
Then the "button" "Validate" is "be.enabled"
# And I can see the step "Validate data" is finished


#REP-818
Scenario:  q) As a data provider can't change value of this read-only field

Given I'm logged at Reportnet page as 'userProvider'
When I filter the dataflow list by "name" with "Dataset Reportnet Testing"
And I click on "Dataset Reportnet Testing"
And I can click on element "DS-Test"
And I click on table "Table4"
Then I "can not" update the cell with the text "1" to the text "2" in a "dataset"


#REP-819
Scenario:  r) As a data provider I can't modify the number of records in this table

Given I'm logged at Reportnet page as 'userProvider'
When I filter the dataflow list by "name" with "Dataset Reportnet Testing"
And I click on "Dataset Reportnet Testing"
And I can click on element "DS-Test"
And I click on table "Table4"
Then the "button" "Import table data" is "not.exist"


@sanity
Scenario: s) Edit dataset table row

Given I'm logged at Reportnet page as 'userProvider'
When I filter the dataflow list by "name" with "Dataset Reportnet Testing"
And I click on "Dataset Reportnet Testing"
And I can click on element "DS-Test"
Then I "can" update the cell with the text "data1" to the text "123" in a "dataset"


#REP-855
@sanity
Scenario: t) As a custodian in design dataset or a reporter in reporting dataset, I want to be able to select with a check, in the import dialogue, if I want to append rows o replace. (Improve regular import dialogue)

Given I'm logged at Reportnet page as 'userProvider'
When I filter the dataflow list by "name" with "Dataset Reportnet Testing"
And I click on "Dataset Reportnet Testing"
And I can click on element "DS-Test"
And the dataset table "Table1" has 2 records
And the "button" "Import table data" is "be.enabled"
When I check replace data
And I import a file "test2.csv"
And I see the message: "SUCCESS"
And I reload the page
Then the dataset table "Table1" has 2 records


@sanity
Scenario: u) Delete dataset table row

Given I'm logged at Reportnet page as 'userProvider'
When I filter the dataflow list by "name" with "Dataset Reportnet Testing"
And I click on "Dataset Reportnet Testing"
And I can click on element "DS-Test"
And the dataset table "Table1" has 2 records
When I delete the dataset table row 1
And I reload the page
Then the dataset table "Table1" has 1 records


Scenario: v) Paste data to dataset

Given I'm logged at Reportnet page as 'userProvider'
When I filter the dataflow list by "name" with "Dataset Reportnet Testing"
And I click on "Dataset Reportnet Testing"
And I can click on element "DS-Test"
And the "button" "Paste records" is "be.enabled"
And I paste the data from file "test_paste.txt"
And I reload the page
Then the dataset table "Table1" has 2 records


@sanity
Scenario: x) Delete table data

Given I'm logged at Reportnet page as 'userProvider'
When I filter the dataflow list by "name" with "Dataset Reportnet Testing"
And I click on "Dataset Reportnet Testing"
And I can click on element "DS-Test"
And the "button" "Delete table data" is "be.enabled"
And I delete the table data
And I reload the page
Then the dataset table "Table1" has 0 records


#REP-822
Scenario: y) As a reporter, I can see the datasets marked as Final feedback

Given I'm logged at Reportnet page as 'userProvider'
When I filter the dataflow list by "name" with "Dataset Reportnet Testing"
And I click on "Dataset Reportnet Testing"
And I can click on element "DS2"
Then I see the message: "Final feedback"


#REP-2047
Scenario: z) As a lead reporter, I can remove the option for a Member States to make a data private when it has been publicly released

Given I'm logged at Reportnet page as 'userProvider'
When I filter the dataflow list by "name" with "Dataset Reportnet Testing"
And I click on "Dataset Reportnet Testing"
And I can click on element "DS-Test"
And I can add a record
    | 1 |  |
And I can go to the dataflow page
And I can click on element "DS2"
And I can add a record
    | 1 |  |
And I can go to the dataflow page
Then the "action" "Release data visibility" is "be.visible"
And I "can not" change to public in the visibility modal
When I can click on element "Release to data collection"
And I can confirm release to data collection with "restrict to public"
And I see the message SUCCESS RELEASE TO DATA COLLECTION
Then the "action" "Release data visibility" is "be.visible"
And I "can" change to public in the visibility modal  
Then the "action" "Release data visibility" is "be.visible"
And I "can not" change to public in the visibility modal  


Scenario Outline: za) As Data Custodian I can see Dataset Schemas to dataflow

Given I'm logged at Reportnet page as "userCustodian"
When I filter the dataflow list by "name" with "Dataset Reportnet Testing"
And I click on "Dataset Reportnet Testing"
And I can click on element "Dataflow help"
And I click on the tab "Dataset schemas"
Then I can see the dataset schema "<datasetName>"

Examples:
  | datasetName |
  | DS-Test     |


Scenario Outline: zb) As Data Provider I can see Dataset Schemas to dataflow

Given I'm logged at Reportnet page as "userProvider"
When I filter the dataflow list by "name" with "Dataset Reportnet Testing"
And I click on "Dataset Reportnet Testing"
And I can click on element "Dataflow help"
And I click on the tab "Dataset schemas"
Then I can see the dataset schema "<datasetName>"

Examples:
  | datasetName |
  | DS-Test     |








