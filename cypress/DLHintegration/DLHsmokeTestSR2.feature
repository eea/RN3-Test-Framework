 Feature: DLH UAT Service Request 2

Scenario: a) As a data custodian I can add a new data flow with obligations

Given I'm logged at DHL Reportnet page as "userCustodian2"
And the "action" "Create new dataflow" is "be.visible"
Then I "Create" a reporting dataflow with name "Dataflow Reportnet Testing" and description "Dataflow description test" and obligation "(C) Information on the assessment regime (Article 7)" in big data storage with "noFilters" 
And I click on "Dataflow Reportnet Testing"
And I can click on element "Manage lead reporters"
Then I can "add" a Data provider with Representative of "All countries: EEA member countries PLUS other countries and territories" and account "test.provider2@abc.com" and Data provider "Spain"


Scenario: b) As a data custodian I can create new dataset schema

Given I'm logged at Reportnet page as 'userCustodian2'
And I click on "Dataflow Reportnet Testing"
And I can click on element "New schema"
And I can create a dataset schema public available with name "DS-Test"
And Confirm new dataset schema creation is visible
Then I can click on element "DS-Test"
Then I can go to the list dataflows page
And I click on "Dataflow Reportnet Testing"
And I can click on element "New schema"
And I can create a dataset schema public available with name "DS2"
And Confirm new dataset schema creation is visible
And I can click on element "DS2"

Scenario: c) As a data custodian I can fill a dataset schema

Given I'm logged at Reportnet page as 'userCustodian2'
And I click on "Dataflow Reportnet Testing"
And I can click on element "DS-Test"
Then I can fill a dataset schema with name "Table1", description "description Table1" and with following fields
 | Table1Field1 | Field 1 description | Number - Integer | | true |
 | Table1Field2 | Field 2 description | Number - Integer | |      |
Then I mark the table as a "available for manual editting"
And I can click the edit records manually checkbox
And I change to "Tabular data" mode
And I can add a record 
| 1 | 1 |
And I can add a record 
| 2 | 2 |
And I can click the edit records manually checkbox
And I can go to the list dataflows page
And I click on "Dataflow Reportnet Testing"
And I can click on element "DS2"
Then I can fill a dataset schema with name "T1", description "description T1" and with following fields
 | f1 | Field 1 description | Number - Integer | | true |
 | f2 | Field 2 description | Text             | |      | 
Then I mark the table as a "available for manual editting"
And I can click the edit records manually checkbox
And I change to "Tabular data" mode
And I can add a record 
| 1 | test1 |
And I can add a record 
| 2 | test2 |
And I can click the edit records manually checkbox

Scenario: d) As a data custodian I want to be able to set a design dataset as reference dataset

Given I'm logged at Reportnet page as 'userCustodian2'
When I filter the dataflow list by "name" with "Dataflow Reportnet Testing"
And I click on "Dataflow Reportnet Testing"
Then I can click on element "New schema"
And I can create a dataset schema public available with name "Reference data"
And Confirm new dataset schema creation is visible
And I can click on element "Reference data"
And I can fill a dataset schema with name "Information", description "description Information" and with following fields
 | code  | description 1 | Text | | true |
 | label | description 2 | Text | |      |
Then I mark the table as a "available for manual editting"
And I can click the edit records manually checkbox
And I change to "Tabular data" mode
And I can add a record 
| 1 | test1 |
And I can add a record 
| 2 | test2 |
And I can click the edit records manually checkbox
And I set the design dataset as "Reference dataset"
And the "button" "External integrations" is "be.disabled"
And the "fieldsDesigner" "Read only" is "checked"
And the "fieldsDesigner" "Read only" is "be.disabled"
And the "fieldsDesigner" "Prefilled" is "checked"
And the "fieldsDesigner" "Prefilled" is "be.disabled"
And the "button" "Configure webform" is "be.disabled"

Scenario: e) As a data custodian I can fill a read only (and prefill) dataset schema 

Given I'm logged at Reportnet page as 'userCustodian2'
When I filter the dataflow list by "name" with "Dataflow Reportnet Testing"
And I click on "Dataflow Reportnet Testing"
And I can click on element "DS-Test"
Then I can fill a dataset schema with name "Table2", description "description Table2" and with following fields
 | Field1 | Field 1 description | Number - Integer | | |
 | Field2 | Field 2 description | Link | | |
And I can select a "Link" "Information - code" with label field "label" and linked field "Field1" and master field "label" and ignore case "" for dataflow ""
Then I mark the table as a "read only"
Then I mark the table as a "available for manual editting"
And I can click the edit records manually checkbox
And I change to "Tabular data" mode
And I can add a record 
|1| link | test1 |
And I can add a record 
|2| link | test2 |
And I can click the edit records manually checkbox

Scenario: f) As a data custodian I can fill a prefilled dataset schema 

Given I'm logged at Reportnet page as 'userCustodian2'
And I click on "Dataflow Reportnet Testing"
And I can click on element "DS-Test"
And I can fill a dataset schema with name "Table3", description "description Table3" and with following fields
 | Field1 | Field 1 description | Number - Integer | | |
 Then I mark the table as a "prefilled"
Then I mark the table as a "available for manual editting"
And I can click the edit records manually checkbox
And I change to "Tabular data" mode
And I can add a record 
|3| |
And I can add a record 
|4| |
And I can click the edit records manually checkbox

Scenario: g) As a Custodian, I am able to mark a field as read-only and fixed number of records so reporters can't change value of this field and can't modify the number of records

Given I'm logged at Reportnet page as 'userCustodian2'
And I click on "Dataflow Reportnet Testing"
And I can click on element "DS-Test"
Then I can fill a dataset schema with name "Table4", description "description Table4" and with following fields
 | Field1 | Field 1 description | Number - Integer | | false | true |
And I mark the table as a "prefilled"
And I mark the table as a "fixed number of records"
Then I mark the table as a "available for manual editting"
And I can click the edit records manually checkbox
And I change to "Tabular data" mode
And I can add a record 
|1| |
And I can click the edit records manually checkbox

Scenario: h) As a data custodian I can create data collections

Given I'm logged at Reportnet page as 'userCustodian2'
And I click on "Dataflow Reportnet Testing"
And I can click on element "Create data collections"
Then I can create data collections with a technical acceptance step for the reporter submissions and "public"
And I wait for notification
And I wait for notification
And I see the message: "SUCCESS"

Scenario: i) As a data provider I cannot modify a read only table

Given I'm logged at Reportnet3 page as "userProvider2"
When I filter the dataflow list by "name" with "Dataflow Reportnet Testing"
And I click on "Dataflow Reportnet Testing" 
And I can click on element "DS-Test"
Then I click on table "Table2"
And the "button" "Import table data" is "not.exist"
And I can go to the dataflow page
And I can click on element "DS-Test"
Then the dataset table "Table3" has 2 records

Scenario: j) As a data provider I can see the prefilled table

Given I'm logged at Reportnet3 page as "userProvider2"
And I wait for enter
When I filter the dataflow list by "name" with "Dataflow Reportnet Testing"
And I click on "Dataflow Reportnet Testing"
And I can click on element "DS-Test"
Then the dataset table "Table3" has 2 records

Scenario: k) As a data custodian I can create new dataflow and dataset schema with a webform table

Given I'm logged at Reportnet page as "userCustodian2"
And the "action" "Create new dataflow" is "be.visible"
Then I "Create" a reporting dataflow with name "Webform Test" and description "Webform Test" and obligation "(C) Information on the assessment regime (Article 7)" in big data storage with "noFilters" 
And I click on "Webform Test"
Then I can click on element "New schema"
And I can create a dataset schema public available with name "DS-Test"
And Confirm new dataset schema creation is visible

Scenario: l) As a custodian, I want to configure the webform used in each dataset

Given I'm logged at Reportnet page as "userCustodian2"
And I click on "Webform Test"
And I can click on element "DS-Test"
And I can click on "Configure webform"
And I select the "Governance Regulation Art. 13" webform developed in the system
When I change to "Webform" mode
Then I will see the webform configured


Scenario: m) As a data custodian I can delete a data flow

Given I'm logged at Reportnet page as "userCustodian2"
And I click on "Webform Test"
And the "action" "Edit" is "be.visible"
Then I can delete the dataflow "Webform Test"


Scenario: n) As an admin I can manage webforms

Given I'm logged at Reportnet page as "userAdmin"
And the "action" "Manage webforms" is "be.visible"
And I can see the list of webforms
    | Governance Regulation | PaMs   |
    | National Systems      | Q&A    |
And I can add a new webform "test" and "Tables"
And the "button" "Select file" is "be.enabled"
When I upload the webform from file "Tables webform example.json"
Then I can see the updated list of webforms "test"

