Feature: Background main application testing


Scenario Outline: As a custodian I can add a dataflow

Given I'm logged at Reportnet page as "userCustodian"
Then the "action" "Create new dataflow" is "<visible>"
 Examples: 
 | visible     |
 | be.visible  | 


Scenario Outline: As a provider I cannot add a dataflow

Given I'm logged at Reportnet page as "userProvider"
Then the "action" "Create new dataflow" is "<visible>"
 Examples: 
 | visible     |
 | not.exist   | 



@sanity 
Scenario: As a data custodian I can add a new data flow with obligations

Given I'm logged at Reportnet page as 'userCustodian'
And the "action" "Create new dataflow" is "be.visible"
Then I "Create" a reporting dataflow with name "Dataflow Reportnet Testing" and description "Dataflow description test" and obligation "(C) Information on the assessment regime (Article 7)" with "noFilters"
And I click on "Dataflow Reportnet Testing"
And the "action" "Manage requesters" is "be.visible"
And I can "Add" a editor "test.provider@abc.com" with permissions "CUSTODIAN"
And I can "Add" a editor "national.spain@reportnet.net" with permissions "CUSTODIAN"
And I click on close button

#REP-1817
@sanity 
Scenario: As a data custodian I can create new dataset schema

Given I'm logged at Reportnet page as 'userCustodian'
And I click on "Dataflow Reportnet Testing"
And I can click on element "New schema"
And I can "create" a dataset schema with name "DS-Test"
Then I can click on element "DS-Test"
And publicly available check is "not.be.disabled"
And I can toggle publicly available check
Then I can go to the list dataflows page
And I click on "Dataflow Reportnet Testing"
And I can click on element "New schema"
And I can "create" a dataset schema with name "DS2"
And I can click on element "DS2"


# REP-816

Scenario: As a data custodian I can see the integration to FME is already created

Given I'm logged at Reportnet page as 'userCustodian'
And I click on "Dataflow Reportnet Testing"
And I can click on element "DS-Test"
And I click on the tab "External integrations"
And The integration "Export EU Dataset" is "be.visible" on the list of external integrations


# REP-1488 

Scenario: As a custodian/steward, I want to be able to configure schema in the Export EU dataset and to get the attachments by field_value_id.

Given I'm logged at Reportnet page as 'userCustodian'
And I click on "Dataflow Reportnet Testing"
And I can click on element "DS-Test"
And I click on the tab "External integrations"
Then I can "Edit" the new external integration "Export EU Dataset"
| schema | dbo |


# REP-851 REP-925
@sanity 
Scenario: As a custodian, I want to configure an integration to pre-filled data for each reporter.

Given I'm logged at Reportnet page as 'userCustodian'
And I click on "Dataflow Reportnet Testing"
And I can click on element "DS-Test"
And I click on the tab "External integrations"
When I can click on "Create external integration"
Then I can "Create" the new external integration ""
| Test External integration | Test description | ReportNetTesting | prefilling.fmw | EXPORT | csv | p1 | 1 |
And The integration "Test External integration" is "be.visible" on the list of external integrations


# REP-925

Scenario: As a custodian, I want to configure an integration with duplicated name.

Given I'm logged at Reportnet page as 'userCustodian'
And I click on "Dataflow Reportnet Testing"
And I can click on element "DS-Test"
And I click on the tab "External integrations"
When I can click on "Create external integration"
Then I can "Create" the new external integration "duplicated"
| Test External integration | Test description | ReportNetTesting | prefilling.fmw | EXPORT | csv | p1 | 1 |


# REP-925
Scenario: As a custodian,  I see the list of external exports with the name

Given I'm logged at Reportnet page as 'userCustodian'
And I click on "Dataflow Reportnet Testing"
And I can click on element "DS-Test"
And I click on the tab "Export dataset data"
Then I can see the list of external "exports" with the name "Test External integration"



Scenario: As a data custodian I can fill a dataset schema

Given I'm logged at Reportnet page as 'userCustodian'
And I click on "Dataflow Reportnet Testing"
And I can click on element "DS-Test"
Then I can fill a dataset schema with name "Table1", description "description Table1" and with following fields
 | Field1 | Field 1 description | Number - Integer | | true |
 | Field2 | Field 2 description | Text             | |      |
And I can go to the list dataflows page
And I click on "Dataflow Reportnet Testing"
And I can click on element "DS2"
Then I can fill a dataset schema with name "T1", description "description T1" and with following fields
 | f1 | Field 1 description | Number - Integer | | true |
 | f2 | Field 2 description | Text             | |      | 

 
#REP-384 REP-459
@sanity
Scenario: As a data custodian I can create new field constraint QC Rules

Given I'm logged at Reportnet page as 'userCustodian'
And I click on "Dataflow Reportnet Testing"
And I can click on element "DS-Test"
When the "button" "QC rules" is "be.visible"
Then I can "create" the field constraint rule with fields
| Table1 | Field1 | blocker Test | testName | Field type NUMBER | Message Info | Blocker |
And I can "Create" a "Field comparison" with a "" with fields
 | false  | AND | Number | <= | 100  |
And the code rule "blocker Test" is "be.visible" on the list of rules


# REP-1312
Scenario: As a data custodian I want to be able to set a design dataset as reference dataset

Given I'm logged at Reportnet page as 'userCustodian'
And I click on "Dataflow Reportnet Testing"
Then I can click on element "New schema"
And I can "create" a dataset schema with name "Reference data"
And I can click on element "Reference data"
Then I can fill a dataset schema with name "Information", description "description Information" and with following fields
 | code  | description 1 | Text | | true |
 | label | description 2 | Text | | true |
And I change to "Tabular data" mode
And I can add a record 
| 1 | test1 |
And I can add a record 
| 2 | test2 |
And I set the design dataset as "Reference dataset"
And I set the design dataset as "Available in public view"
And the "button" "External integrations" is "be.disabled"
And the "fieldsDesigner" "Read only" is "checked"
And the "fieldsDesigner" "Read only" is "be.disabled"
And the "fieldsDesigner" "Prefilled" is "checked"
And the "fieldsDesigner" "Prefilled" is "be.disabled"
And the "button" "Configure webform" is "be.disabled"


#REP-457
@sanity
Scenario: As a data custodian I can fill a read only (and prefill) dataset schema 

Given I'm logged at Reportnet page as 'userCustodian'
And I click on "Dataflow Reportnet Testing"
And I can click on element "DS-Test"
And I can fill a dataset schema with name "Table2", description "description Table2" and with following fields
 | Field1 | Field 1 description | Number - Integer | | |
 | Field2 | Field 2 description | Link | | |
And I can select a "Link" "Table1 - Field1" with label field "" and linked field "" and master field "" and ignore case "" for dataflow ""
And I change to "Tabular data" mode
And I can add a record 
|1| |
And I can add a record 
|2| |
Then I mark the table as a "read only"


#REP-458
Scenario: As a data custodian I can fill a prefilled dataset schema 

Given I'm logged at Reportnet page as 'userCustodian'
And I click on "Dataflow Reportnet Testing"
And I can click on element "DS-Test"
And I can fill a dataset schema with name "Table3", description "description Table3" and with following fields
 | Field1 | Field 1 description | Number - Integer | | |
And I change to "Tabular data" mode
And I can add a record 
|3| |
And I can add a record 
|4| |
Then I mark the table as a "prefilled"


#REP-818 REP-819
@sanity
Scenario: As a Custodian, I am able to mark a field as read-only and fixed number of records so reporters can't change value of this field and can't modify the number of records

Given I'm logged at Reportnet page as 'userCustodian'
And I click on "Dataflow Reportnet Testing"
And I can click on element "DS-Test"
Then I can fill a dataset schema with name "Table4", description "description Table4" and with following fields
 | Field1 | Field 1 description | Number - Integer | | false | true |
And I mark the table as a "prefilled"
And I mark the table as a "fixed number of records"
And I change to "Tabular data" mode
And I can add a record 
|1| |


# REP-850
@sanity
Scenario: As a data custodian I can add a Data provider

Given I'm logged at Reportnet page as 'userCustodian'
And I click on "Dataflow Reportnet Testing"
And I can click on element "Manage lead reporters"
Then I can "add" a Data provider with Representative of "EEA Member countries" and account "test.provider@abc.com" and Data provider "Spain"
And I can click on element "Manage lead reporters"
And I can "addToCountry" a Data provider with Representative of "EEA Member countries" and account "testleadreporter@reportnet.net" and Data provider "Spain"
And I can click on element "Manage lead reporters"
And I can "addMore" a Data provider with Representative of "EEA Member countries" and account "test.provider@abc.com" and Data provider "France"
And I can click on element "Manage lead reporters"
And I can "Import" Lead reporters
And I import a file "importLeadReporters.csv"
And I can see the representative "Spain" "test.provider@abc.com"
And I can see the representative "Finland" "test.provider@abc.com"


# REP-822 REP-1192
@sanity
Scenario: As a data custodian I can create data collections

Given I'm logged at Reportnet page as 'userCustodian'
And I click on "Dataflow Reportnet Testing"
And I can change on "DS-Test" the type of field "Field 2" on table "Table2" to "Text"
And I can go to the list dataflows page
And I click on "Dataflow Reportnet Testing"
And I can click on element "Create data collections"
Then I can create data collections with a technical acceptance step for the reporter submissions and "public"
And I see the message: "SUCCESS"


# REP-1027
Scenario: As a data custodian with a created DC, new TEST dataset per schema is created

Given I'm logged at Reportnet page as 'userCustodian'
And I click on "Dataflow Reportnet Testing"
Then the "action" "Test dataset" is "be.visible"
And I can click on element "Test dataset"
And the "action" "Test Dataset - DS-Test" is "be.visible"
And the "action" "Test Dataset - DS2" is "be.visible"


# REP-1027
Scenario: As a data custodian I can add/delete data and validate data on the new Test dataset

Given I'm logged at Reportnet page as 'userCustodian'
And I click on "Dataflow Reportnet Testing"
When I can click on element "Test dataset"
And I can click on element "Test Dataset - DS-Test"
Then I can add a record 
| 101 | |
And I delete the dataset table row 1
And the "button" "Validate" is "be.enabled"
And I see the message: "SUCCESS"


# REP-1027
Scenario: As a data provider I don't have access to these new datasets

Given I'm logged at Reportnet page as "userProvider"
And I click on "Dataflow Reportnet Testing"
Then the "button" "Test dataset" is "not.exist"


# REP-926
@sanity
Scenario: As an NC, I want to have access to all dataflows of my country.

Given I'm logged at Reportnet page as "userNC"
And I click on "Dataflow Reportnet Testing"
And I can click on element "DS-Test"
Then the "button" "Import table data" is "be.disabled"


# REP-816
Scenario: As a data custodian I can see the EU dataset is already created for each Data collection

Given I'm logged at Reportnet page as 'userCustodian'
And I click on "Dataflow Reportnet Testing"
And I can click on element "EU Dataset - DS-Test"


# REP-816
Scenario: As a data custodian I can export EU Datasets

Given I'm logged at Reportnet page as 'userCustodian'
And I click on "Dataflow Reportnet Testing"
Then I can click on element "Export EU datasets"


#REP-457
Scenario: As a data provider I can not modify a read only table

Given I'm logged at Reportnet page as "userProvider"
And I click on "Dataflow Reportnet Testing" 
And I can click on element "Spain"
And I can click on element "DS-Test"
Then I click on table "Table2"
And the "button" "Import table data" is "not.exist"


#REP-458
Scenario: As a data provider I can see the prefilled table

Given I'm logged at Reportnet page as "userProvider"
And I click on "Dataflow Reportnet Testing"
And I can click on element "Spain"
And I can click on element "DS-Test"
Then the dataset table "Table3" has 2 records


#REP-1670
Scenario: As a custodian, I can allow multiple extensions in external integrations

Given I'm logged at Reportnet page as 'userCustodian'
And I click on "Dataflow Reportnet Testing"
And I can click on element "DS-Test"
And I click on the tab "External integrations"
When I can click on "Create external integration"
Then I can "Create" the new external integration ""
| Test External integration multiple extension | Test description | ReportNetTesting | prefilling.fmw | IMPORT | csv, zip | p1 | 1 |
And The integration "Test External integration multiple extension" is "be.visible" on the list of external integrations


#REP-944
Scenario: As a custodian, I want to be able to communicate with lead reporters of a country.

Given I'm logged at Reportnet page as 'userCustodian'
And I click on "Dataflow Reportnet Testing"
And I can click on element "Technical feedback"
When I select the country "Spain" 
Then I can "send" the message "Test communication"
And I can "send" the message "Test message"


#REP-1314
Scenario: As a custodian, I can delete a message

Given I'm logged at Reportnet page as 'userCustodian'
And I click on "Dataflow Reportnet Testing"
And I can click on element "Technical feedback"
When I select the country "Spain"
Then I can "delete" the message "Test message" 


#REP-1314
Scenario: As a custodian, I can attach a file

Given I'm logged at Reportnet page as 'userCustodian'
And I click on "Dataflow Reportnet Testing"
And I can click on element "Technical feedback"
When I select the country "Spain" 
And the "button" "Attach file" is "be.enabled"
Then I import a file "importLeadReporters.csv"

#REP-1839
Scenario: As an admin, I can send system notification to all users

Given I'm logged at Reportnet page as 'userAdmin'
And the "action" "System notifications" is "be.visible"
When I create a system notification with "testMessage" message and "INFO" level and active "enabled"
Then I see the notification "testMessage" in the system notifications list


#REP-1839
Scenario: As a custodian, I can see a system notification sent by an admin

Given I'm logged at Reportnet page as 'userCustodian'
Then I can see a system notification "testMessage" sent by an Admin


#REP-1839
Scenario: As an admin, I can delete a system notification

Given I'm logged at Reportnet page as 'userAdmin'
And the "action" "System notifications" is "be.visible"
Then I delete a system notification with "testMessage" message

Scenario: Only as a data custodian I can see the dashboards

Given I'm logged at Reportnet page as 'userCustodian'
And I click on "Dataflow Reportnet Testing"
Then the "action" "Dashboards" is "<visible>"

  Examples: 
  | visible     | 
  | be.visible  | 

Scenario: As a provider I cannot see the dashboards

Given I'm logged at Reportnet page as "userProvider"
And I click on "Dataflow Reportnet Testing"
Then the "action" "Dashboards" is "<visible>"

  Examples: 
  | visible     | 
  | not.exist   | 


@sanity
Scenario: As a data custodian I see the Validation dashboards and Release status

Given I'm logged at Reportnet page as 'userCustodian'
And I click on "Dataflow Reportnet Testing"
And I can click on element "Dashboards"
Then I can see the Release status dashboard and Validation dashboards
