Feature: Reportnet Dataflow - As an existing user on the Repornet system I want to test the actions with dataflow data


@sanity
Scenario: As a data custodian I can add a new data flow

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And the "action" "Create new dataflow" is "be.visible"
Then I can "Create" a dataflow with name "New Test" and description "new description New Test" and obligation "(C) Information on the assessment regime (Article 7)" with "noFilters"
And I can click on "New Test"
And I can click on element "New schema"
And I can "create" a dataset schema with name "DS-Test"
And I can click on element "DS-Test"
Then I can fill a dataset schema with name "Table1", description "description Table1" and with following fields
 | Field1 | Field 1 description | Number - Integer | | true |


# REP-1192 REP-1312 REP-1432 REP-1275
Scenario Outline: As a public user I can see the list of all dataflows marked as publicly available

Given I'm in Reportnet page
And I can click on "View by obligation dataflow"
And I can filter by "name" with "Dataflow Reportnet Testing"
Then I "can" see the publicly dataflow "Dataflow Reportnet Testing"
And I can see for dataflow "Dataflow Reportnet Testing" the instrument "Agenda 21 National Report", status "Open"
And I can see the information on "Dataflow Reportnet Testing" with "<country>" "<type>" "<technicalAcceptance>"
And I login as user "testcustodian" and password "1234"

 Examples: 
    | country            | type                 | technicalAcceptance |
    | Finland            | not released         |                     |
    | France             | not released         |                     |
    | Spain              | not released         |                     |
    | Reference datasets | reference data       |                     |
    | Finland            | technical acceptance |                     |
    | France             | technical acceptance | Pending             |
    | Spain              | technical acceptance | Pending             |


# REP-1242 REP-1432 REP-1275
Scenario: As a public user I can see the list of dataflows by country

Given I'm in Reportnet page
And I can click on "View by country dataflow"
Then I can click on "Spain"
And I can filter by "name" with "Dataflow Reportnet Testing"
And I can see the list of dataflows for "Spain"
    | Dataflow Reportnet Testing | Agenda 21 National Report | UNCED Agenda 21 | Open | Final feedback |
And I login as user "testcustodian" and password "1234"


@sanity
Scenario: As a data custodian I can edit a data flow

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "New Test"
And the "action" "Edit" is "be.visible"
Then I can "Save" a dataflow with name "Test edited" and description "old description Test2" and obligation "(C) Preliminary information on the assessment regime (Article 7)" with "noFilters"


Scenario Outline: As a Reportnet User I can see the roles on the dataflow list

Given I'm logged at Reportnet page as user "<user>" and password "<password>"
Then I can see the "<role>" on "Dataflow Reportnet Testing"

  Examples:
    | user          | password | role      |
    | testprovider  | 1234     | REPORTER  |
    | testcustodian | 1234     | CUSTODIAN |


#REP-822
Scenario: As a reporter, I can see the status of the dataflows

Given I'm logged at Reportnet page as user "testprovider" and password "1234"
Then I can see the "Delivery status" on "Dataflow Reportnet Testing"


#REP-1994
Scenario Outline: As a Reportnet User I can filter the dataflow list

Given I'm logged at Reportnet page as user "<user>" and password "<password>"
And the dataflow list has 2 items
Then I can filter by "<type>" with "<filter>"
And the dataflow list has <total> items

  Examples:
    | user          | password | type        | filter    | total |
    | testcustodian | 1234     | name        | reportnet | 1     |
    | testcustodian | 1234     | description | dataflow  | 1     |
    | testcustodian | 1234     | Status      | DESIGN    | 1     |
    | testcustodian | 1234     | Role        | CUSTODIAN | 2     |


#REP-1994
Scenario Outline: As a Reportnet User I can clear filters in the dataflow list

Given I'm logged at Reportnet page as user "<user>" and password "<password>"
And the dataflow list has 2 items
When I can filter by "<type>" with "<filter>"
And the dataflow list has <total> items
Then I can clear dataflow filters
And the dataflow list has 2 items

  Examples:
    | user          | password | type        | filter    | total |
    | testcustodian | 1234     | name        | reportnet | 1     |
    | testcustodian | 1234     | name        | reportnet | 1     |
    | testcustodian | 1234     | description | dataflow  | 1     |


# REP-1141
Scenario Outline: As a user, I want to be able to pin and unpin some dataflows in the dataflow list.

Given I'm logged at Reportnet page as user "<user>" and password "<password>"
Then I can "<pin>" the dataflow "<dataflow>"
And I see the message: "<message>"

  Examples:
    | user          | password | pin   | dataflow                       | message                        |
    | testcustodian | 1234     | unpin | Dataflow Reportnet Testing     | You have unpinned the dataflow |
    | testcustodian | 1234     | pin   | Test edited                    | You have pinned the dataflow   |
    | testcustodian | 1234     | unpin | Test edited                    | You have unpinned the dataflow |


#REP-1994
Scenario Outline: As a Reportnet User I can sort the dataflow list

Given I'm logged at Reportnet page as user "<user>" and password "<password>"
And I sort the dataflow list by "<field>"
Then The first dataflow is "<first>" and the last dataflow is "<last>"

  Examples:
    | user          | password | field              | first       | last                       |
    | testcustodian | 1234     | Name               | Test edited | Dataflow Reportnet Testing |
    | testcustodian | 1234     | Description        | Test edited | Dataflow Reportnet Testing |
    | testcustodian | 1234     | Status             | Test edited | Dataflow Reportnet Testing |
    | testcustodian | 1234     | Legal Instrument   | Test edited | Dataflow Reportnet Testing |


# REP-1210
@sanity
Scenario Outline: As a custodian, I can Close/open release process

Given I'm logged at Reportnet page as user "testcustodian" and password "<password>"
And I can see the "<status>" on "<dataflow>"
And I can click on "<dataflow>"
And the "action" "Releasing status" is "be.visible"
When I click the check to "<action>" the reporting
And I can go to the list dataflows page
And I can see the "<nextStatus>" on "<dataflow>"
And The user logout
And I login as user "testprovider" and password "<password>"
And I can click on "<dataflow>"
And I can click on element "Spain"
Then the button "Release to data collection" is "<visibility>"

  Examples:
    | user          | password | status | nextStatus | dataflow                   | action | visibility  |
    | testcustodian | 1234     | OPEN   | CLOSED     | Dataflow Reportnet Testing | close  | not.exist |
    | testcustodian | 1234     | CLOSED | OPEN       | Dataflow Reportnet Testing | open   | visible     |


#REP-1367
Scenario: As a requester (custodian/steward), in an open dataflow I am able to create more unique constraints

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "Dataflow Reportnet Testing"
And I can click on element "DS-Test"
And the "button" "Unique constraints" is "be.visible"
Then I can add unique constraint on "Table4" with "Field1"
Then the table Unique constraints has 2 records


#REP-1496
@sanity
Scenario: As a registered user I can import a zip file through an external integration

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "Test edited"
And I can click on element "DS-Test"
And the "button" "External integrations" is "be.visible"
And the "button" "Create external integration" is "be.visible"
Then I can "Create" the new external integration "import"
  | ZIP | ZIP | ReportNetTesting | ImportZIP_test.fmw | IMPORT | zip | p1 | 1 |
And the "button" "Close" is "be.visible"
And I can click on the tab "Import dataset data"
Then I can see the list of external "imports" with the name "ZIP (.zip)"
And I can click on the list element with the name "ZIP (.zip)"
And I import a file "DS-Test.zip"
Then I see the message: "SUCCESS"
And the "action" "Notifications" is "be.visible"
Then I see the notification "Loaded data completed at DS-Test" in the notification received list


@sanity
Scenario: As a data custodian I can delete a data flow

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "Test edited"
And the "action" "Edit" is "be.visible"
Then I can delete the dataflow "Test edited"
And I see the message: "SUCCESS"


#REP-413
@sanity
Scenario: As a data provider I can create a API-KEY

Given I'm logged at Reportnet page as user "testprovider" and password "1234"
And I can click on "Dataflow Reportnet Testing"
And I can click on element "Spain"
And the "action" "API-key" is "be.visible"
Then the "button" "Generate new API-key" is "be.enabled"
And new API-key is created


#REP-1322
Scenario: As a registered user I can export with an option (zip XLSX + attachments)

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "Dataflow Reportnet Testing"
And I can click on element "Spain"
And I can click on element "DS2"
Then the "button" "Export dataset data" is "be.enabled"
And I can export dataset data "ZIP (.xlsx + attachments)"
And I see the message: "SUCCESS"


#REP-1206
Scenario: As a registered user I can export with an option (zip CVS + attachments)

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "Dataflow Reportnet Testing"
And I can click on element "Spain"
And I can click on element "DS2"
Then the "button" "Export dataset data" is "be.enabled"
And I can export dataset data "ZIP (.csv for each table)"
And I see the message: "SUCCESS"


#REP-1396
Scenario: As a registered user I can export with an option (.xlsx with validations)

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "Dataflow Reportnet Testing"
And I can click on element "Spain"
And I can click on element "DS2"
Then the "button" "Export dataset data" is "be.enabled"
And I can export dataset data "XLSX (.xlsx with validations)"
And I see the message: "SUCCESS"


#REP-1438 REP-1605
@sanity
Scenario: As a custodian/steward, I want to be able to create a Reference dataflow.

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "Reference dataflows"
And the "action" "Create new dataflow" is "be.visible"
Then I can "Create" a reference dataflow with name "Reference dataflow1" and description "new description Reference Test"
And I can click on "Reference dataflow1"
And I can click on element "New schema"
And I can "create" a dataset schema with name "DS-Reference-Test"
And I can click on element "DS-Reference-Test"
Then I can fill a dataset schema with name "Table1", description "description Table1" and with following fields
  | code  | code description  | Number - Integer |  | true  |
  | label | label description | Text             |  | false |
Then I can fill a dataset schema with name "Table2", description "description Table2" and with following fields
  | code  | code description  | Number - Integer |  | false |
  | label | label description | Text             |  | false |
And I click on table "Table1"
And I change to "Tabular data" mode
And I can add a record
  | 1 | test1 |
And I can add a record
  | 2 | test2 |
And I can add a record
  | 3 | test3 |
And I can go to the dataflow page
And I can create reference datasets
And I can see a warning for the tables without PK
And I see the message: "SUCCESS"
And I can go to the list dataflows page
And I can click on "Reference dataflows"
And I can filter by "name" with "Reference dataflow1"
And I can click on "Reference dataflow1"
And the "action" "Referencing dataflows" is "be.visible"


#REP-1438
Scenario: As a custodian/steward, I want to be able to update data in a reference dataset if it is marked as updatable.

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "Reference dataflows"
And I can filter by "name" with "Reference dataflow1"
And I can click on "Reference dataflow1"
And I can click on element "DS-Reference-Test"
And I "can not" update the cell with the text "test1" to the text "test4" in a "reference dataset"
And the "action" "Update status" is "be.visible"
When I "Unlock" the reference dataset
And I "can" update the cell with the text "test1" to the text "test4" in a "reference dataset"
And the "action" "Update status" is "be.visible"
Then I "Lock" the reference dataset
And I "can not" update the cell with the text "test2" to the text "test4" in a "reference dataset"


#REP-1604
@sanity
Scenario: As a admin, I want to be able to create a Business dataflow.

Given I'm logged at Reportnet page as user "test.admin" and password "1234"
And I can click on tab "Business dataflows"
And the "action" "Create new dataflow" is "be.visible"
Then I can "Create" a business dataflow with name "Business dataflow1" and description "new description Business Test" and obligation "(C) Information on the assessment regime (Article 7)" and company "Company Group 1" with fmeUser "Reportnet3"
Then I can click on "Business dataflow1"
And the "action" "Manage requesters" is "be.visible"
And I can "Add" a editor "testcustodian@reportnet.net" with permissions "CUSTODIAN"


#REP-1689
@sanity
Scenario: As a custodian, I want to be able to create a Citizen and science dataflow.

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on tab "Citizen science dataflows"
And the "action" "Create new dataflow" is "be.visible"
Then I can "Create" a dataflow with name "Citizen test dataflow" and description "new description Citizen Test" and obligation "(C) Information on the assessment regime (Article 7)" with "noFilters"


#REP-1647
Scenario: As an admin, I want to be able to see all dataflows.

Given I'm logged at Reportnet page as user "test.admin" and password "1234"
Then I can click on "Dataflow Reportnet Testing"
And I can click on element "Dataflow help"
And I can go to the list dataflows page
Then I can click on "Dataflow Reportnet Testing"
And the "action" "Manage requesters" is "be.visible"
And I can go to the list dataflows page
And I can click on tab "Business dataflows"
Then I can click on "Business dataflow1"
And I can go to the list dataflows page
And I can click on "Reference dataflows"
Then I can click on "Reference dataflow1"
And I can go to the list dataflows page
And I can click on "Citizen science dataflows"
Then I can click on "Citizen test"


#REP-1687
Scenario: As a custodian/steward, I want to be able to set a BDR dataflow as public or not but only for dataflow help

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on tab "Business dataflows"
Then I can click on "Business dataflow1"
And I can click on element "Dataflow help"
And the "button" "Upload" is "be.enabled"
When I "upload" the document "test.csv" with description "public document" and language "English" marked as "public"
And I can go to the dataflow page
And I can click on element "New schema"
And I can "create" a dataset schema with name "DS-Business-Test"
And I can click on element "DS-Business-Test"
Then I can fill a dataset schema with name "Table1", description "description Table1" and with following fields
  | code  | code description  | Number - Integer |  | true  |
  | label | label description | Text             |  | false |
And I click on table "Table1"
And I change to "Tabular data" mode
And I can add a record
  | 1 | test1 |
And I can add a record
  | 2 | test2 |
And I can add a record
  | 3 | test3 |
And I can go to the dataflow page
And I can click on element "Manage lead reporters"
Then I can "add" a Data provider in a BDR with account "testprovider@reportnet.net" and Data provider "Company1"
And I can click on element "Create data collections"
Then I can create data collections with a technical acceptance step for the reporter submissions and "public"
And I see the message: "SUCCESS"
And The user logout
And I can click on "View by obligation dataflow"
Then I "can" see the publicly dataflow "Business dataflow1"
And I can see for dataflow "Business dataflow1" the instrument "(C) Information on the assessment regime (Article 7)", status "Open"
When I can click on "Business dataflow1"
Then the public table "Documents" has 1 records
And I login as user "testcustodian" and password "1234"


#REP-1755
Scenario Outline: As a custodian or provider, I should not be able to manage requesters in a Business dataflow

Given I'm logged at Reportnet page as user "<user>" and password "<password>"
And I can click on tab "Business dataflows"
Then I can click on "Business dataflow1"
And the "action" "Manage requesters" is "not.exist"

  Examples:
    | user          | password |
    | testcustodian | 1234     |
    | testprovider  | 1234     |


#REP-1841
Scenario: As a Custodian I want to be able to assign a Lead Reporter whose email doesn't exist to a Dataflow

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on tab "Business dataflows"
Then I can click on "Business dataflow1"
And I can click on element "Manage lead reporters"
Then I can "addMore" a Data provider in a BDR with account "temporaryLead@reportnet.net" and Data provider "Company2"
And I can click on element "Manage lead reporters"
Then I can see a tag next to the invalid lead reporter email


#REP-1841
Scenario: As a Lead Reporter I want to be able to assign a Reporter whose email doesn't exist to a Dataflow

Given I'm logged at Reportnet page as user "testleadreporter" and password "1234"
And I can click on "Dataflow Reportnet Testing"
And I can click on element "Spain"
And the "action" "Manage reporters" is "be.visible"
When I can "Add" a editor "temporaryReporter@reportnet.net" with permissions "REPORTER WRITE"
Then I can see a tag next to the invalid reporter email


#REP-2161
Scenario: As a custodian/steward I can enable to automatically delete reporter data and snapshots with technical acceptance of delivery

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "Dataflow Reportnet Testing"
When the "action" "Automatic delete" is "be.visible"
Then I can check enable automatic delete reporter data and snaphots


#REP-2231
Scenario Outline: As a user I can/cannot edit a dataflow name

Given I'm logged at Reportnet page as user "<user>" and password "1234"
And I can filter by "name" with "<dataflowName>"
And I can click on "<dataflowName>"
Then I "<action>" a dataflow with name "<dataflowNameEdited>" 

Examples: 
    | dataflowName               | dataflowNameEdited                 | user          | action       |
    | Dataflow Reportnet Testing | Dataflow Reportnet Testing edited  | test.admin    | can edit     |
    | Dataflow Reportnet Testing | Dataflow Reportnet Testing edited  | testcustodian | cannot edit  | 
