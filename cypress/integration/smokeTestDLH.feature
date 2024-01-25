
Feature: DHL UAT

Scenario: a) As a data custodian I can add a new data flow with obligations

Given I'm logged at DHL Reportnet page as "DHLuserCustodian"
And the "action" "Create new dataflow" is "be.visible"
Then I "Create" a reporting dataflow with name "UAT Testing" and description "Dataflow description test" and obligation "(C) Information on the assessment regime (Article 7)" with "noFilters"
And I click on "UAT Testing"
And the "action" "Manage requesters" is "be.visible"
And I can "Add" a editor "national.spain@reportnet.net" with permissions "CUSTODIAN"
And I click on close button


Scenario: b) As a data custodian I can create new dataset schema

Given I'm logged at DHL Reportnet page as "DHLuserCustodian"
And I click on "UAT Testing"
And I can click on element "New schema"
And I can create a dataset schema public available with name "DS-Test"
And Confirm new dataset schema creation is visible
Then I can click on element "DS-Test"
Then I can go to the list dataflows page
And I click on "UAT Testing"
And I can click on element "New schema"
And I can create a dataset schema public available with name "DS2"
And Confirm new dataset schema creation is visible
And I can click on element "DS2"


Scenario: c) As a data custodian I can fill a dataset schema

Given I'm logged at DHL Reportnet page as "DHLuserCustodian"
And I click on "UAT Testing"
And I can click on element "DS-Test"
Then I can fill a dataset schema with name "Table1", description "description Table1" and with following fields
 | Field1 | Field 1 description | Number - Integer | | true |
 | Field2 | Field 2 description | Text             | |      |
And I can go to the list dataflows page
And I click on "UAT Testing"
And I can click on element "DS2"
Then I can fill a dataset schema with name "T1", description "description T1" and with following fields
 | f1 | Field 1 description | Number - Integer | | true |
 | f2 | Field 2 description | Text             | |      |
And I can go to the list dataflows page
And I click on "UAT Testing"
And I can click on element "DS-Test"
Then I can fill a dataset schema with name "Table4", description "description Table4" and with following fields
 | Field1 | Field 1 description | Number - Integer | | false | true |
And I mark the table as a "prefilled"
And I mark the table as a "fixed number of records"
And I change to "Tabular data" mode
And I can add a record 
|1| |


Scenario: d) As a data custodian I can add a Data provider

Given I'm logged at DHL Reportnet page as "DHLuserCustodian"
And I click on "UAT Testing"
And I can click on element "Manage lead reporters"
Then I can "add" a Data provider with Representative of "All countries: EEA member countries PLUS other countries and territories" and account "test.provider@abc.com" and Data provider "Spain"
And I can click on element "Manage lead reporters"
And I can "addToCountry" a Data provider with Representative of "All countries: EEA member countries PLUS other countries and territories" and account "testleadreporter@reportnet.net" and Data provider "Spain"
And I can click on element "Manage lead reporters"
And I can "addMore" a Data provider with Representative of "All countries: EEA member countries PLUS other countries and territories" and account "seray.kilinc@trasys.gr" and Data provider "France"
And I can click on element "Manage lead reporters"
And I can "Import" Lead reporters
And I import a file "importLeadReporters.csv"
And I can see the representative "Spain" "test.provider@abc.com"



Scenario: e) As a data custodian I can create data collections

Given I'm logged at DHL Reportnet page as "DHLuserCustodian"
And I click on "UAT Testing"
And I can click on element "Create data collections"
Then I can create data collections with a technical acceptance step for the reporter submissions and "public"
And I wait for notification
And I see the message: "SUCCESS"


Scenario: f) As a LEAD REPORTER, I want to release data with validations passed.

Given I'm logged at DHL Reportnet page as "DHLuserProvider"
When I filter the dataflow list by "name" with "UAT Testing"
And I click on "UAT Testing"
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
And I wait for importing the file
Then I see the message: "SUCCESS"


Scenario: g) Edit dataset table row

Given I'm logged at DHL Reportnet page as "DHLuserProvider"
And I wait for enter
When I filter the dataflow list by "name" with "UAT Testing"
And I click on "UAT Testing"
And I can click on element "DS-Test"
Then I "can" update the cell with the text "data1" to the text "123" in a "dataset"


Scenario: h) As a custodian in design dataset or a reporter in reporting dataset, I want to be able to select with a check, in the import dialogue, if I want to append rows o replace. (Improve regular import dialogue)

Given I'm logged at DHL Reportnet page as "DHLuserProvider"
And I wait for enter
When I filter the dataflow list by "name" with "UAT Testing"
And I click on "UAT Testing"
And I can click on element "DS-Test"
And the dataset table "Table1" has 2 records
And the "button" "Import table data" is "be.enabled"
When I check replace data
And I import a file "test2.csv"
And I wait for enter
And I see the message: "SUCCESS"
And I reload the page
Then the dataset table "Table1" has 2 records


@sanity
Scenario: i) Delete dataset table row

Given I'm logged at DHL Reportnet page as "DHLuserProvider"
And I wait for enter
When I filter the dataflow list by "name" with "UAT Testing"
And I click on "UAT Testing"
And I can click on element "DS-Test"
And the dataset table "Table1" has 2 records
When I delete the dataset table row 1
And I reload the page
Then the dataset table "Table1" has 1 records


Scenario: j) Paste data to dataset

Given I'm logged at DHL Reportnet page as "DHLuserProvider"
And I wait for enter
When I filter the dataflow list by "name" with "UAT Testing"
And I click on "UAT Testing"
And I can click on element "DS-Test"
And the "button" "Paste records" is "be.enabled"
And I paste the data from file "test_paste.txt"
And I reload the page
Then the dataset table "Table1" has 2 records



Scenario: k) Delete table data

Given I'm logged at DHL Reportnet page as "DHLuserProvider"
And I wait for enter
When I filter the dataflow list by "name" with "UAT Testing"
And I click on "UAT Testing"
And I can click on element "DS-Test"
And the "button" "Delete table data" is "be.enabled"
And I delete the table data
And I reload the page
Then the dataset table "Table1" has 0 records







