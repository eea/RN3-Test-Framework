Feature: Reportnet Roles - As an existing user on the Repornet system I want to test the actions with Roles

@sanity
Scenario: As a data custodian I can add a new data flow

Given I'm logged at Reportnet page as user "te.custodian" and password "1234"
And the "action" "Create new dataflow" is "be.visible"
Then I can "Create" a dataflow with name "Roles Reportnet Testing" and description "Description Roles Reportnet Testing" and obligation "(C) Information on the assessment regime (Article 7)" with "noFilters"
And I can click on "Roles Reportnet Testing"
And I can click on element "New schema"
And I can "create" a dataset schema with name "DS-Test"
And I can click on "DS-Test"


@sanity
Scenario: As a data custodian I can add a Data provider

Given I'm logged at Reportnet page as user "te.custodian" and password "1234"
And I can click on "Roles Reportnet Testing"
And I can click on element "Manage lead reporters"
Then I can "add" a Data provider with Representative of "EEA Member countries" and account "testprovider@reportnet.net" and Data provider "Spain"


Scenario: As a data custodian I can edit a Data provider

Given I'm logged at Reportnet page as user "te.custodian" and password "1234"
And I can click on "Roles Reportnet Testing"
And I can click on element "Manage lead reporters"
Then I can "edit" a Data provider with Representative of "EEA Member countries" and account "testcustodian@reportnet.net" and Data provider "France"


Scenario: As a data custodian I can delete a Data provider

Given I'm logged at Reportnet page as user "te.custodian" and password "1234"
And I can click on "Roles Reportnet Testing"
And I can click on element "Manage lead reporters"
Then I can "delete" a Data provider with Representative of "EEA Member countries" and account "testprovider@reportnet.net" and Data provider "France"


# REP-708
Scenario: As a CUSTODIAN or STEWARD, I want to share access rights with editors in my dataflow

Given I'm logged at Reportnet page as user "te.custodian" and password "1234"
And I can click on "Roles Reportnet Testing"
And the "action" "Manage requesters" is "be.visible"
When I can "Add" a editor "testprovider@reportnet.net" with permissions "EDITOR WRITE"
And The user logout
And I login as user "testprovider" and password "1234"
And I can click on "Roles Reportnet Testing"
And I can click on element "DS-Test"
Then I can fill a dataset schema with name "Table1", description "description Table1" and with following fields
| table1f1 | description 1 | Number - Integer |  | true |


@sanity
Scenario: As a data custodian I can add a Data provider

Given I'm logged at Reportnet page as user "te.custodian" and password "1234"
And I can click on "Roles Reportnet Testing"
And I can click on element "Manage lead reporters"
Then I can "add" a Data provider with Representative of "EEA Member countries" and account "testprovider@reportnet.net" and Data provider "Spain"


@sanity
Scenario: As a data custodian I can create data collections

Given I'm logged at Reportnet page as user "te.custodian" and password "1234"
And I can click on "Roles Reportnet Testing"
And I can click on element "Create data collections"
Then I can create data collections with a technical acceptance step for the reporter submissions and "public"
And I see the message: "SUCCESS"


# REP-36
@sanity
Scenario: As a LEAD REPORTER, I want to share access rights with reporters for a dataflow

Given I'm logged at Reportnet page as user "testprovider" and password "1234"
And I can click on "Roles Reportnet Testing"
And the "action" "Manage reporters" is "be.visible"
When I can "Add" a editor "testcustodian2@reportnet.net" with permissions "REPORTER WRITE"
And The user logout
And I login as user "te.custodian2" and password "1234"
And I can click on "Roles Reportnet Testing"
And I can click on element "DS-Test"


# REP-382
@sanity
Scenario: As a data custodian I can add more representatives when a DC is already created

Given I'm logged at Reportnet page as user "te.custodian" and password "1234"
And I can click on "Roles Reportnet Testing"
And I can click on element "Manage lead reporters"
Then I can "addLast" a Data provider with Representative of "EEA Member countries" and account "testprovider@reportnet.net" and Data provider "Belgium"
And I reload the page
And I can click on element "Create new datasets"
And I can add datasets for new Representatives
And I see the message: "SUCCESS"
And I can click on element "Belgium"


# REP-987 REP-1349
Scenario: As a custodian I can see all the users of the dataflow for this country

Given I'm logged at Reportnet page as user "te.custodian" and password "1234"
And I can click on "Roles Reportnet Testing"
And I can click on element "Spain"
And the "action" "Dataflow users list" is "be.visible"
Then I can see the specified record in the table
| national.spain@reportnet.net   | NATIONAL COORDINATOR |
| testcustodian@reportnet.net    | CUSTODIAN            |
| testcustodian2@reportnet.net   | REPORTER WRITE       |
| testprovider@reportnet.net     | LEAD REPORTER        |


# REP-1349
Scenario: As a NC I can see all the users of the dataflow for this country

Given I'm logged at Reportnet page as user "national.spain@reportnet.net" and password "1234"
And the "action" "All dataflows user list" is "be.visible"
And I can filter by "dataflowName" with "Roles Reportnet Testing"
Then I can see the specified record in the table
| national.spain@reportnet.net | NATIONAL COORDINATOR |
| testcustodian2@reportnet.net | REPORTER WRITE       |
| testprovider@reportnet.net   | LEAD REPORTER        |


# REP-1349
Scenario: As a reporter I can see all the users of the dataflow for this country

Given I'm logged at Reportnet page as user "testprovider@reportnet.net" and password "1234"
And I can click on "Roles Reportnet Testing"
And I can click on element "Spain"
And the "action" "Dataflow users list" is "be.visible"
Then I can see the specified record in the table
| testcustodian2@reportnet.net   | REPORTER WRITE |
| testprovider@reportnet.net     | LEAD REPORTER  |


@sanity
Scenario: As a LEAD REPORTER, I want to release data with validations passed.

Given I'm logged at Reportnet page as user "testprovider" and password "1234"
And I can click on "Roles Reportnet Testing"
And I can click on element "Spain"
And I can click on element "DS-Test"
And I can add a record
    | 101 |  |
And I can go to the dataflow page
And I can click on element "Spain"
When I can click on element "Release to data collection"
And I can confirm release to data collection with "no restrict to public"
And I see the message: "SUCCESS"


#REP-2230
Scenario Outline: As a reporter in multiple providers inside a dataflow, I can see the status for each provider in dataflow list and inside the dataflow

Given I'm logged at Reportnet page as user "testprovider" and password "1234"
And I can see the "<delivery status>" on "Roles Reportnet Testing"
And I can click on "Roles Reportnet Testing"
Then I can see the status for the "Spain" dataset

  Examples:
    | delivery status |
    | MULTIPLE        |


# REP-1335
Scenario: As a custodian, I want to see the list of current custodians/stewards and be able to add custodians/stewards/observers.

Given I'm logged at Reportnet page as user "te.custodian" and password "1234"
And I can click on "Roles Reportnet Testing"
And the "action" "Manage requesters" is "be.visible"
And I can "Add" a editor "testleadreporter@reportnet.net" with permissions "STEWARD"
And I can see the specified record in the table
| testleadreporter@reportnet.net | STEWARD |
And I can "Add" a editor "testobserver@reportnet.net" with permissions "OBSERVER"
And I can see the specified record in the table
| testobserver@reportnet.net | OBSERVER |
And The user logout
Then I login as user "testleadreporter" and password "1234"
And I can click on "Roles Reportnet Testing"
And I can click on element "DS-Test"
And The user logout
And I login as user "testobserver" and password "1234"
And I can click on "Roles Reportnet Testing"
And I can click on element "Dashboards"
And I can see the Release status dashboard and Validation dashboards
And I can go to the dataflow page
And I can click on element "Data Collection - DS-Test"
And I can go to the dataflow page
And the "action" "Releasing status" is "not.exist"
And the "action" "Export schema" is "be.not.exist"
And the "button" "Copy Data Collections to EU Datasets" is "not.exist"


# REP-1304 REP-1503
Scenario: As a observer user I am able to see (read only) help

Given I'm logged at Reportnet page as user "testobserver" and password "1234"
When I can click on "Roles Reportnet Testing"
Then I can click on element "Dataflow help"
And the table "Supporting documents" has 0 records
And I can go to the dataflow page
And I can click on element "Dashboards"
And I can see the Release status dashboard and Validation dashboards
And I can go to the dataflow page
And I can click on element "Data Collection - DS-Test"
And I can go to the dataflow page
And the "action" "Releasing status" is "not.exist"
And the "action" "Export schema" is "be.not.exist"
And the "button" "Copy Data Collections to EU Datasets" is "not.exist"
And I can click on element "Belgium"
And I can go to the dataflow page
And I can click on element "Spain"
And I can go to the dataflow page
And I click in a button "Historic releases" inside "Spain" context menu
And the table "Historic releases for Spain" has 1 records
And I click in a button "Historic releases" inside "EU Dataset - DS-Test" context menu
And the table "Historic releases for EU Dataset - DS-Test" has 0 records
And I click in a button "Historic releases" inside "Data Collection - DS-Test" context menu
And the table "Historic releases for Data Collection - DS-Test" has 1 records
And I can go to the dataflow page


# REP-1335
Scenario: As a custodian, I want to see the list of current custodians/stewards and be able to remove observer users for a dataflow.

Given I'm logged at Reportnet page as user "te.custodian" and password "1234"
And I can click on "Roles Reportnet Testing"
And the "action" "Manage requesters" is "be.visible"
When I can "delete" a editor "testobserver@reportnet.net" with permissions "OBSERVER"
And The user logout
And I login as user "testobserver" and password "1234"
Then The dataflow "Roles Reportnet Testing" doesn't exist


# REP-1336 REP-1858
Scenario: As a custodian, I want to see the list of all users in a dataflow

Given I'm logged at Reportnet page as user "te.custodian" and password "1234"
And I can click on "Roles Reportnet Testing"
And the "action" "Users list by country" is "be.visible"
Then I can see the specified records in the table

    | CUSTODIAN     | testcustodian@reportnet.net    |         |
    | LEAD REPORTER | testprovider@reportnet.net     | Belgium |
    | LEAD REPORTER | testprovider@reportnet.net     | Spain   |
    | STEWARD | testleadreporter@reportnet.net       |         |
And I can click on "Download users list"
And I see the message: "SUCCESS"


# REP-1478
Scenario: As an admin, I want to be able to see a helpdesk inside a dataflow containing info about all the datasets

Given I'm logged at Reportnet page as user "test.admin" and password "1234"
And I can click on "Roles Reportnet Testing"
And the "action" "Datasets info" is "be.visible"
Then I can see the specified records in the table
    | DS-Test                   | Design dataset    |              |
    | EU Dataset - DS-Test      | EU dataset        |              |
    | Test Dataset - DS-Test    | Test dataset      |              |
    | Spain - DS-Test           | Reporting dataset | Spain (ES)   |
    | Belgium - DS-Test         | Reporting dataset | Belgium (BE) |
    | Data Collection - DS-Test | Data Collection   |              |


# REP-2046
@sanity
Scenario: As a custodian, I want to be able to add a new role called STEWARD SUPPORT in manage requesters

Given I'm logged at Reportnet page as user "te.custodian" and password "1234"
And I can click on "Roles Reportnet Testing"
And the "action" "Manage requesters" is "be.visible"
And I can "Add" a editor "teststewardsupport@reportnet.net" with permissions "STEWARD SUPPORT"
And I can see the specified record in the table
| teststewardsupport@reportnet.net | STEWARD SUPPORT |


# REP-2046
Scenario: As a steward support, I want to be able to edit data in a test dataset

Given I'm logged at Reportnet page as user "teststewardsupport" and password "1234"
And I can click on "Roles Reportnet Testing"
When I can click on element "Test dataset"
And I can click on element "Test Dataset - DS-Test"
Then I can add a record 
| 101 | |
And I delete the dataset table row 1


# REP-2046
Scenario: As a steward support, I want to be able to manage Technical feedback/Manual technical acceptance

Given I'm logged at Reportnet page as user "teststewardsupport" and password "1234"
And I can click on "Roles Reportnet Testing"
And I can click on element "Manual technical acceptance"
When I see the datasets with manual technical acceptance for dataflow "Roles Reportnet Testing"
Then I can change the dataset "Spain" to status "Technically accepted" and message "status changed"
And I can see the dataset "Spain" with status "Technically accepted"
And I can click on element "Technical feedback"
And I select the country "Spain"
And I can see the message received "status changed"
Then I can "send" the message "Test communication"
And I can "send" the message "Test message"
Then I can "delete" the message "Test message" 


# REP-2046
Scenario: As a steward support, I want to be able to upload, edit, download and delete documents

Given I'm logged at Reportnet page as user "teststewardsupport" and password "1234"
And I can click on "Roles Reportnet Testing"
And I can click on element "Dataflow help"
And the "button" "Upload" is "be.enabled"
When I "upload" the document "test.csv" with description "test description" and language "English" marked as "private"
And I see the message: "INFO"
And I see the message: "SUCCESS"
Then the table "Supporting documents" has 1 records
And I reload the page
When I "edit" the row 1
And I "edit" the document "Table1.csv" with description "description edited" and language "Spanish" marked as "private"
Then I see the message: "INFO"
And I see the message: "SUCCESS"
And I reload the page
Then I can download the document
When I "delete" the row 1
And I reload the page
Then the table "Supporting documents" has 0 records


# REP-2046
Scenario: As a steward support, I want to be able to upload, edit and delete weblinks

Given I'm logged at Reportnet page as user "teststewardsupport" and password "1234"
And I can click on "Roles Reportnet Testing"
And I can click on element "Dataflow help"
And I can click on the tab "Web links"
And the "button" "Add" is "be.enabled"
When I add a weblink with description "Test webLink" and url "www.google.es" marked as "private"
Then the table "Web links" has 1 records
Then I can update the weblink with the description "Edit weblink" to the text "www.google2.com"
When I "delete" the row 1
Then the table "Web links" has 0 records


# REP-2046
Scenario: As a steward support, I want to be able to manage lead reporters

Given I'm logged at Reportnet page as user "teststewardsupport" and password "1234"
And I can click on "Roles Reportnet Testing"
And I can click on element "Manage lead reporters"
And I can "addToCountry" a Data provider with Representative of "EEA Member countries" and account "testleadreporter@reportnet.net" and Data provider "Belgium"
And I can click on element "Manage lead reporters"
Then I can "delete" a Data provider with Representative of "EEA Member countries" and account "testleadreporter@reportnet.net" and Data provider "Belgium"


# REP-2229
@sanity
Scenario: As an admin, I can add national coordinators

Given I'm logged at Reportnet page as user "test.admin" and password "1234"
And the "action" "National coordinators" is "be.visible"
Then I can add a national coordinator with email "testobserver@reportnet.net" for country "Spain"


# REP-2229
Scenario: As a user designed as national coordinator I can see all the dataflows from a country

Given I'm logged at Reportnet page as user "testobserver" and password "1234"
And I can filter by "Role" with "NATIONAL COORDINATOR"
Then I can click on "Roles Reportnet Testing"


# REP-2283
Scenario: As an admin I can not filter by role

Given I'm logged at Reportnet page as user "test.admin" and password "1234"
Then I can not filter by "role"


# sREP-2220
Scenario: As an admin I can see the job log for validations

Given I'm logged at Reportnet page as user "test.admin" and password "1234"
And the "action" "Validations status" is "be.visible"
Then I can see the list of validations and a refresh button
     

