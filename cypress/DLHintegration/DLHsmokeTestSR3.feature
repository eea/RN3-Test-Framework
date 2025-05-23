 Feature: DLH UAT Service Request 3

Scenario: a) As a data custodian I can add a new data flow with obligations

Given I'm logged at DHL Reportnet page as "userCustodian2"
And the "action" "Create new dataflow" is "be.visible"
Then I "Create" a reporting dataflow with name "Dataflow Reportnet Testing" and description "Dataflow description test" and obligation "(C) Information on the assessment regime (Article 7)" in big data storage with "noFilters" 
And I click on "Dataflow Reportnet Testing"
And I can click on element "Manage lead reporters"
Then I can "add" a Data provider with Representative of "All countries: EEA member countries PLUS other countries and territories" and account "test.provider2@abc.com" and Data provider "Spain"

Scenario: b) As a data custodian I want to be able to set a design dataset as reference dataset

Given I'm logged at Reportnet page as 'userCustodian2'
When I filter the dataflow list by "name" with "Dataflow Reportnet Testing"
And I click on "Dataflow Reportnet Testing"
Then I can click on element "New schema"
And I can create a dataset schema public available with name "Reference data"
And Confirm new dataset schema creation is visible
And I can click on element "Reference data"
And I can fill a dataset schema with name "Information", description "description Information" and with following fields
 | label  | description 1 | Text             | |       |
 | code   | description 2 | Number - Integer | | true  |
Then I mark the table as a "available for manual editting"
And I can click the edit records manually checkbox
And I change to "Tabular data" mode
And I can add a record 
| test12 | 12 |
And I can add a record 
| test13 | 13 |
And I can add a record 
| test11 | 11 |
And I can click the edit records manually checkbox
And I wait for enter
And I set the design dataset as "Reference dataset"

Scenario: c) As a data custodian I can create new dataset schema

Given I'm logged at Reportnet page as 'userCustodian2'
And I click on "Dataflow Reportnet Testing"
And I can click on element "New schema"
And I can create a dataset schema public available with name "DS-Test"
And Confirm new dataset schema creation is visible
Then I can click on element "DS-Test"
Then I can go to the list dataflows page
And I click on "Dataflow Reportnet Testing"

Scenario: d) As a data custodian, I can import a file and view its statistics on the table info page.

Given I'm logged at Reportnet page as 'userCustodian2'
When I filter the dataflow list by "name" with "Dataflow Reportnet Testing"
And I click on "Dataflow Reportnet Testing"
And I can click on element "DS-Test"
Then I can fill a dataset schema with name "Table1", description "description Table1" and with following fields
 | Field1 | Field 1 description | Number - Integer | | |
 | Field2 | Field 2 description | Link | | |
And I can select a "Link" "Information - label" with label field "code" and linked field "Field1" and master field "code" and ignore case "true" for dataflow ""
Then I mark the table as a "available for manual editting"
And I change to "Tabular data" mode
And the "button" "Import table data" is "be.enabled"
And I import a file "LinkTable1.csv"
And I see the message: "SUCCESS"
And I reload the page
And I can click the info button near the table name
And I can see the last import date, the number of records imported, and the file extension of the imported file on the table info page


Scenario: e) As an Admin, I can see the tabular data and validate capital case records using the ignore case option in link fields.

Given I'm logged at Reportnet page as 'userAdmin'
And I click on "Dataflow Reportnet Testing"
And I can click on element "DS-Test"
And I change to "Tabular data" mode
Then the "button" "Validate" is "be.enabled"
And I wait for notification
And I see the message: "SUCCESS"
And I reload the page
And the "button" "Show validations" is "be.visible"
And I can see the "there are no issues with the data" on the validation page


Scenario: f) As a data custodian I can create data collections

Given I'm logged at Reportnet page as 'userCustodian2'
And I click on "Dataflow Reportnet Testing"
And I can click on element "Create data collections"
Then I can create data collections with a technical acceptance step for the reporter submissions and "public"
And I wait for notification
And I see the message: "SUCCESS"

Scenario: g) As a provider I can release to data collection

Given I'm logged at Reportnet3 page as "userProvider2"
And I filter the dataflow list by "name" with "Dataflow Reportnet Testing"
And I click on "Dataflow Reportnet Testing"
And I can click on element "DS-Test"
When the "button" "Import table data" is "be.enabled"
And I import a file "LinkTable12.csv"
Then I see the message: "SUCCESS"
And I reload the page
And I can go to the dataflow page
And I wait for enter
And I can click on element "Release to data collection"
And I can confirm release to data collection with "no restrict to public"
And I wait for notification
And I see the message: "SUCCESS"

Scenario: h) As a provider I can edit the table data 

Given I'm logged at Reportnet3 page as "userProvider2"
And I filter the dataflow list by "name" with "Dataflow Reportnet Testing"
And I click on "Dataflow Reportnet Testing"
And I can click on element "Reference data"
And I can go to the dataflow page
And I can click on element "DS-Test"
And I click the edit records manually checkbox as a provider
And I can add a record 
| 14 | |
And I click the edit records manually checkbox as a provider

# @ignore
# Scenario: i) As a data custodian I can see the edited icon on the dataset block

# Given I'm logged at Reportnet page as 'userCustodian2'
# And I click on "Dataflow Reportnet Testing"
# Then I can see the edit icon on the dataset block

Scenario: j) As a data custodian I can flag this dataflow for deletion

Given I'm logged at Reportnet page as 'userCustodian2'
And I click on "Dataflow Reportnet Testing"
And the "action" "Edit" is "be.visible"
Then I can Flag this dataflow for deletion "Dataflow Reportnet Testing"
And I can go to the dataflow page
And I can click on element "DS-Test"
Then I see the message: "Will be deleted automatically on: "
