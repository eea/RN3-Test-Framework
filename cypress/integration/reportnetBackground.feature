Feature: Main application testing

Scenario Outline: a) As a provider I cannot add a dataflow

Given I'm logged at Reportnet page as "userProvider"
Then the "action" "Create new dataflow" is "<visible>"
 Examples: 
 | visible     |
 | not.exist   | 

Scenario: b) As a data custodian I can add a new data flow with obligations

Given I'm logged at Reportnet page as 'userCustodian'
And the "action" "Create new dataflow" is "be.visible"
Then I "Create" a reporting dataflow with name "Dataflow Reportnet Testing" and description "Dataflow description test" and obligation "(C) Information on the assessment regime (Article 7)" with "noFilters"
And I click on "Dataflow Reportnet Testing"
And the "action" "Manage requesters" is "be.visible"
And I can "Add" a editor "test.provider@abc.com" with permissions "CUSTODIAN"
And I can "Add" a editor "national.spain@reportnet.net" with permissions "CUSTODIAN"
And I click on close button

#REP-1817
Scenario: c) As a data custodian I can create new dataset schema

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


Scenario: d) As a data custodian I can fill a dataset schema

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
Scenario: e) As a data custodian I can create new field constraint QC Rules

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
Scenario: f) As a data custodian I want to be able to set a design dataset as reference dataset

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
Scenario: g) As a data custodian I can fill a read only (and prefill) dataset schema 

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
Scenario: h) As a data custodian I can fill a prefilled dataset schema 

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
Scenario: i) As a Custodian, I am able to mark a field as read-only and fixed number of records so reporters can't change value of this field and can't modify the number of records

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
Scenario: j) As a data custodian I can add a Data provider

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
Scenario: k) As a data custodian I can create data collections

Given I'm logged at Reportnet page as 'userCustodian'
And I click on "Dataflow Reportnet Testing"
And I can change on "DS-Test" the type of field "Field 2" on table "Table2" to "Text"
And I can go to the list dataflows page
And I click on "Dataflow Reportnet Testing"
And I can click on element "Create data collections"
Then I can create data collections with a technical acceptance step for the reporter submissions and "public"
And I see the message: "SUCCESS"
And I reload the page
And I click on "Dataflow Reportnet Testing"
And I can click on element "Test dataset"
And the "action" "Test Dataset - DS-Test" is "be.visible"
And the "action" "Test Dataset - DS2" is "be.visible"
And I can go to the dataflow page
And I can click on element "Test dataset"
And I can click on element "Test Dataset - DS-Test"
Then I can add a record 
| 101 | |
And I delete the dataset table row 1
And the "button" "Validate" is "be.enabled"
And I see the message: "SUCCESS"
And I can go to the dataflow page
And I can click on element "Technical feedback"
When I select the country "Spain" 
Then I can "send" the message "Test communication"
And I can "send" the message "Test message"


# REP-1027 
Scenario: n) As a data provider I don't have access to these new datasets

Given I'm logged at Reportnet page as "userProvider"
And I click on "Dataflow Reportnet Testing"
Then the "button" "Test dataset" is "not.exist"

@ignore
Scenario: o) As an NC, I want to have access to all dataflows of my country.

Given I'm logged at Reportnet page as "userNC"
And I click on "Dataflow Reportnet Testing"
And I can click on element "DS-Test"
Then the "button" "Import table data" is "be.disabled"


# REP-816
Scenario: p) As a data custodian I can export EU Datasets

Given I'm logged at Reportnet page as 'userCustodian'
And I click on "Dataflow Reportnet Testing"
Then I can click on element "Export EU datasets"

#REP-457
Scenario: q) As a data provider I cannot modify a read only table

Given I'm logged at Reportnet page as "userProvider"
And I click on "Dataflow Reportnet Testing" 
And I can click on element "Spain"
And I can click on element "DS-Test"
Then I click on table "Table2"
And the "button" "Import table data" is "not.exist"
And I can go to the dataflow page
And I can click on element "Spain"
And I can click on element "DS-Test"
Then the dataset table "Table3" has 2 records



#REP-458
@ignore
Scenario: r) As a data provider I can see the prefilled table

Given I'm logged at Reportnet page as "userProvider"
And I click on "Dataflow Reportnet Testing"
And I can click on element "Spain"
And I can click on element "DS-Test"
Then the dataset table "Table3" has 2 records

#REP-944
Scenario: s) As a custodian, I want to be able to communicate with lead reporters of a country.

Given I'm logged at Reportnet page as 'userCustodian'
And I click on "Dataflow Reportnet Testing"
And I can click on element "Technical feedback"
When I select the country "Spain" 
Then I can "send" the message "Test communication"
And I can "send" the message "Test message"

#REP-1314
@ignore
Scenario: t) As a custodian, I can delete a message

Given I'm logged at Reportnet page as 'userCustodian'
And I click on "Dataflow Reportnet Testing"
And I can click on element "Technical feedback"
When I select the country "Spain"
Then I can "delete" the message "Test message" 


#REP-1314
Scenario: u) As a custodian, I can attach a file

Given I'm logged at Reportnet page as 'userCustodian'
And I click on data collection "Dataflow Reportnet Testing"
And I can click on element "Technical feedback"
When I select the country "Spain" 
And the "button" "Attach file" is "be.enabled"
Then I import a file "importLeadReporters.csv"

#REP-1839
Scenario: v) As an admin, I can send system notification to all users

Given I'm logged at Reportnet page as 'userAdmin'
And the "action" "System notifications" is "be.visible"
When I create a system notification with "testMessage" message and "INFO" level and active "enabled"
Then I see the notification "testMessage" in the system notifications list

#REP-1839
Scenario: w) As a custodian, I can see a system notification sent by an admin

Given I'm logged at Reportnet page as 'userCustodian'
Then I can see a system notification "testMessage" sent by an Admin



#REP-1839
Scenario: x) As an admin, I can delete a system notification

Given I'm logged at Reportnet page as 'userAdmin'
And the "action" "System notifications" is "be.visible"
Then I delete a system notification with "testMessage" message


Scenario Outline: y) As a provider I cannot see the dashboards

Given I'm logged at Reportnet page as "userProvider"
And I click on "Dataflow Reportnet Testing"
Then the "action" "Dashboards" is "<visible>"

  Examples: 
  | visible     | 
  | not.exist   | 

Scenario: z) As a data custodian I see the Validation dashboards and Release status

Given I'm logged at Reportnet page as 'userCustodian'
And I click on "Dataflow Reportnet Testing"
And I can click on element "Dashboards"
Then I can see the Release status dashboard and Validation dashboards

