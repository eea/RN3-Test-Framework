Feature: DLH UAT Service Request 1

Scenario: a) As a data custodian I can add a new data flow with obligations

Given I'm logged at DHL Reportnet page as "userCustodian2"
And the "action" "Create new dataflow" is "be.visible"
Then I "Create" a reporting dataflow with name "UAT DLH Testing" and description "Dataflow description test" and obligation "(C) Information on the assessment regime (Article 7)" in big data storage with "noFilters" 
And I click on "UAT DLH Testing"
And the "action" "Manage requesters" is "be.visible"
And I can "Add" a editor "national.spain@reportnet.net" with permissions "CUSTODIAN"
And I click on close button

Scenario: b) As a data custodian I can create new dataset schema

Given I'm logged at DHL Reportnet page as "userCustodian2"
And I click on "UAT DLH Testing"
And I can click on element "New schema"
And I can create a dataset schema public available with name "DS-DLH-Test"
And Confirm new dataset schema creation is visible
Then I can click on element "DS-DLH-Test"
Then I can go to the list dataflows page
And I click on "UAT DLH Testing"
And I can click on element "New schema"
And I can create a dataset schema public available with name "DS2-DLH"
And Confirm new dataset schema creation is visible
And I can click on element "DS2-DLH"
Then I can go to the list dataflows page
And I click on "UAT DLH Testing"
And I can click on element "New schema"
And I can create a dataset schema public available with name "DS3-Test-DLH"
And Confirm new dataset schema creation is visible
And I can click on element "DS3-Test-DLH"

Scenario: c) As a data custodian I can fill a dataset schema

Given I'm logged at DHL Reportnet page as "userCustodian2"
And I click on "UAT DLH Testing"
# And I can click on element "DS-DLH-Test"
# Then I can fill a dataset schema with name "Table1DLH", description "description Table1" and with following fields
#  | Field1 | Field 1 description | Text             | | true |
#  | Field2 | Field 2 description | Text             | |      |
#  | Field3 | Field 3 description | Number - Integer | |      |
# And I change to "Tabular data" mode
# And the "button" "Import table data" is "be.enabled"
# And I import a file "Table1DLH.csv" with S3
# And I reload the page
# And I can go to the list dataflows page
# And I click on "UAT DLH Testing"
# And I can click on element "DS2-DLH"
# Then I can fill a dataset schema with name "T1DLH", description "description T1" and with following fields
#  | f1 | Field 1 description | Number - Integer | | true |
#  | f2 | Field 2 description | Text             | |      |
# And I change to "Tabular data" mode
# And the "button" "Import table data" is "be.enabled"
# And I import a file "T1DLH.csv" with S3
# And I reload the page
# And I can go to the list dataflows page
# And I click on "UAT DLH Testing"
And I can click on element "DS3-Test-DLH"
Then I can fill a dataset schema with name "Table4DLH", description "description Table4" and with following fields
 | Field1 | Field 1 description | Number - Integer |             | true  |
 | Field2 | Field 2 description | Attachment       | pdf,txt,csv | false |
Then I mark the table as a "available for manual editting"
And I can click the edit records manually checkbox
And I change to "Tabular data" mode
And I can add a record
  | 1 |
And I wait for enter
And I reload the page
And The attach file button is enabled on the field
Then I import a file "t1.csv"
And I wait for enter
And I can click the edit records manually checkbox
And I wait for enter

Scenario: ca) As a data custodian I can add the geometry field

Given I'm logged at DHL Reportnet page as "userCustodian2"
And I click on "UAT DLH Testing"
And I can click on element "DS3-Test-DLH"
And I can fill a dataset schema with name "Table5DLH", description "description Table3" and with following fields
  | description           | description | Text              |  |       |
  | geometry_multipolygon | geometry    | Multiple polygons |  | false |
And I change to "Tabular data" mode
And the "button" "Import table data" is "be.enabled"
When I check replace data
And I import a file "Table5DLH.csv"
And I wait for importing the file
And I see the message: "SUCCESS"
And I reload the page
And the "button" "QC rules" is "be.visible"
And the code rule "Field type MULTIPOLYGON" is "be.visible" on the list of rules

Scenario: cb) As a data custodian I can set the table to be available for manual editting

Given I'm logged at DHL Reportnet page as "userCustodian2"
And I click on "UAT DLH Testing"
And I can click on element "DS-DLH-Test"
Then I mark the table as a "available for manual editting"
And I can click the edit records manually checkbox
And I change to "Tabular data" mode
And The add record button is visible
Then the "button" "Import dataset data" is "be.disabled"
And I reload the page
And I can go to the list dataflows page
And I click on "UAT DLH Testing"
And I can click on element "DS2-DLH"
Then I mark the table as a "available for manual editting"
And I change to "Tabular data" mode
And I can click the edit records manually checkbox

Scenario: d) As a data custodian I can add a Data provider

Given I'm logged at DHL Reportnet page as "userCustodian2"
And I click on "UAT DLH Testing"
And I can click on element "Manage lead reporters"
Then I can "add" a Data provider with Representative of "All countries: EEA member countries PLUS other countries and territories" and account "test.provider2@abc.com" and Data provider "Spain"
And I can click on element "Manage lead reporters"
And I can "addToCountry" a Data provider with Representative of "All countries: EEA member countries PLUS other countries and territories" and account "testleadreporter@reportnet.net" and Data provider "Spain"
And I can click on element "Manage lead reporters"
And I can "addMore" a Data provider with Representative of "All countries: EEA member countries PLUS other countries and territories" and account "test.provider2@abc.com" and Data provider "France"
And I can click on element "Manage lead reporters"
And I can "Import" Lead reporters
And I import a file "importLeadReportersDev.csv"
And I can see the representative "Spain" "test.provider2@abc.com"
And I can see the representative "Finland" "test.provider2@abc.com"

Scenario: e) As a data custodian I can create new field constraint QC Rules (quotes control on inputs)

Given I'm logged at Reportnet page as "userCustodian2"
When I filter the dataflow list by "name" with "UAT DLH Testing"
And I click on "UAT DLH Testing"
And I can click on element "DS-DLH-Test"
And the "button" "QC rules" is "be.visible"
Then I can "create" the field constraint rule with fields
  | Table1DLH | Field3 | qc1 'Test' | test "Name" | Field type "NUMBER" | Message "Info" | ERROR |
And I can "Create" a "Field comparison" with a "group" with fields
  | true  | AND | Number | >= | 10  |
  | false | AND | Number | <= | 100 |
And the code rule "qc1 'Test'" is "be.visible" on the list of rules
And the new qc rule "qc1 'Test'" is "correct"

Scenario: f) As a user, I want to download QC list in CSV

Given I'm logged at Reportnet page as "userCustodian2"
When I filter the dataflow list by "name" with "UAT DLH Testing"
And I click on "UAT DLH Testing"
And I can click on element "DS-DLH-Test"
And the "button" "QC rules" is "be.visible"
When I can click on "Download QCs"
And I see the message: "SUCCESS"

Scenario: g) Validate button is enabled for data Provider

Given I'm logged at Reportnet page as 'userCustodian2'
When I filter the dataflow list by "name" with "UAT DLH Testing"
And I click on "UAT DLH Testing"
And I can click on element "DS-DLH-Test"
And I can click the edit records manually checkbox
Then the "button" "Validate" is "be.enabled"
And I wait for notification
And I see the message: "SUCCESS"
And I can click the edit records manually checkbox

Scenario: h) As a data custodian, I cannot create data collections if the 'Edit Records Manually' checkbox is selected.

Given I'm logged at DHL Reportnet page as "userCustodian2"
When I filter the dataflow list by "name" with "UAT DLH Testing"
And I click on "UAT DLH Testing"
And I can click on element "Create data collections"
Then I can create data collections with a technical acceptance step for the reporter submissions and "public"
And I can see the message: "Failed creating data collection"

Scenario: ha) As a custodian I can add, edit and remove records

Given I'm logged at Reportnet page as 'userCustodian2'
When I filter the dataflow list by "name" with "UAT DLH Testing"
And I click on "UAT DLH Testing"
And I can click on element "DS2-DLH"
And I change to "Tabular data" mode
And I can add a record
  | 1 | test1 |
And I can add a record
  | 2 | test2 |
And I can add a record
  | 3 | test3 |
Then I "can" update the cell with the text "test3" to the text "test3test3test3" in a "dataset"
And I delete the dataset table row 1
And I can click the edit records manually checkbox

Scenario: hb) As a data custodian, I can create data collections

Given I'm logged at DHL Reportnet page as "userCustodian2"
When I filter the dataflow list by "name" with "UAT DLH Testing"
And I click on "UAT DLH Testing"
And I can click on element "Create data collections"
Then I can create data collections with a technical acceptance step for the reporter submissions and "public"
And I wait for notification
And I see the message: "SUCCESS"

Scenario: i) As a LEAD REPORTER, I can import data as a zip file and validate them

Given I'm logged at DHL Reportnet page as "userProvider2"
When I filter the dataflow list by "name" with "UAT DLH Testing"
And I click on "UAT DLH Testing"
And I can click on element "Spain"
And I can click on element "DS2-DLH"
Then I click on the import dataset data button
And I import a "zip" file "DS2-DLH.zip"
And I wait for validation
And I can go to the dataflow page
And I can click on element "Spain"
And I can click on element "DS-DLH-Test"
Then I click on the import dataset data button
And I import a "zip" file "DS-DLH-Test.zip"
And I wait for validation
Then I see the message: "SUCCESS"
And I reload the page
And I can go to the dataflow page
And I can click on element "Spain"
And I can click on element "DS3-Test-DLH"
Then I click on the import dataset data button
Then I import a "zip" file "DS3-Test-DLH.zip"
And I wait for enter
And I can go to the dataflow page
And I can click on element "Spain"
And I can click on element "DS-DLH-Test"
And I can see the user profile page
Then I can change the visual rows to "100"
And the "action" "Dataflows" is "be.visible"
And I filter the dataflow list by "name" with "UAT DLH Testing"
And I click on "UAT DLH Testing"
And I can click on element "Spain"
And I can click on element "DS-DLH-Test"
And the dataset table "Table1" has 100 records

Scenario: ia) As a LEAD REPORTER, I can add, edit and remove manually

Given I'm logged at DHL Reportnet page as "userProvider"
When I filter the dataflow list by "name" with "UAT DLH Testing"
And I click on "UAT DLH Testing"
And I can click on element "Spain"
And I can click on element "DS2-DLH"
And I can click the edit records manually checkbox
And I can add a record
  | 1 | test1 |
And I can add a record
  | 2 | test2 |
And I can add a record
  | 3 | test3 |
Then I "can" update the cell with the text "test3" to the text "test3test3test3" in a "dataset"
And I delete the dataset table row 1

Scenario: ib) As a LEAD REPORTER, I want to release data, but if the 'edit records manually' checkbox is checked for any table, the 'Release to Data Collection' button is disabled.

Given I'm logged at DHL Reportnet page as "userProvider"
When I filter the dataflow list by "name" with "UAT DLH Testing"
And I click on "UAT DLH Testing"
And I can click on element "Spain"
Then I can confirm that the Release to data collection button is disable 
And I can click on element "DS2-DLH"
And I can click the edit records manually checkbox
And I wait for enter


Scenario: j) As a LEAD REPORTER, I want to release data with validations passed.

Given I'm logged at DHL Reportnet page as "userProvider"
When I filter the dataflow list by "name" with "UAT DLH Testing"
And I click on "UAT DLH Testing"
And I can click on element "Spain"
When I can click on element "Release to data collection"
And I can confirm release to data collection with "no restrict to public"
And I wait for importing the file
Then I see the message: "SUCCESS"


Scenario: k) Delete table data

Given I'm logged at DHL Reportnet page as "userProvider"
And I wait for enter
When I filter the dataflow list by "name" with "UAT DLH Testing"
And I click on "UAT DLH Testing"
And I can click on element "Spain"
And I can click on element "DS-DLH-Test"
And the "button" "Delete table data" is "be.enabled"
And I delete the table data
And I reload the page
Then the dataset table "Table1" has 0 records

# Scenario: l) As an admin, I want to be able to create a Business dataflow.

# Given I'm logged at Reportnet page as 'userAdmin'
# And I can click on tab "Business dataflows"
# And the "action" "Create new dataflow" is "be.visible"
# Then I create a business dataflow with name "Business DLH dataflow1" and description "new description Business Test" and obligation "(C) Information on the assessment regime (Article 7)" and company "Company Group 1" in a big dataflow with fmeUser "Reportnet3"
# Then I click on "Business DLH dataflow1"
# And the "action" "Manage requesters" is "be.visible"
# And I can "Add" a editor "test.custodian@abc.com" with permissions "CUSTODIAN"
