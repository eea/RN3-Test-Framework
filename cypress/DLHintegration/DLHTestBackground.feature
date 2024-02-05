Feature: Main application testing

Scenario Outline: a) As a provider I cannot add a dataflow

Given I'm logged at Reportnet3 page as "userDLHProvider"
Then the "action" "Create new dataflow" is "<visible>"
 Examples: 
 | visible     |
 | not.exist   | 


Scenario: b) As a data custodian I can add a new data flow with obligations

Given I'm logged at Reportnet page as 'userCustodian'
And the "action" "Create new dataflow" is "be.visible"
Then I "Create" a reporting dataflow with name "Dataflow Reportnet Testing" and description "Dataflow description test" and obligation "(C) Information on the assessment regime (Article 7)" with "noFilters"
When I filter the dataflow list by "name" with "Dataflow Reportnet Testing"
And I click on "Dataflow Reportnet Testing"
And the "action" "Manage requesters" is "be.visible"
And I can "Add" a editor "test.provider@abc.com" with permissions "CUSTODIAN"
And I can "Add" a editor "national.spain@reportnet.net" with permissions "CUSTODIAN"
And I click on close button

Scenario: ba) As a data custodian I can add a new organization

Given I'm logged at Reportnet page as 'userCustodian'
And the "action" "Add organization" is "be.visible"
Then I can add a new organization with name "Test" with group "All countries: EEA member countries PLUS other countries and territories"
Then I can click on "Refresh"
Then I can filter organizations by "label" with "test"
And I can see the specified record in the table
| Test| All countries: EEA member countries PLUS other countries and territories |


#REP-1817
Scenario: c) As a data custodian I can create new dataset schema

Given I'm logged at Reportnet page as 'userCustodian'
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
When I filter the dataflow list by "name" with "Dataflow Reportnet Testing"
And I click on "Dataflow Reportnet Testing"
And I can click on element "DS-Test"
Then the "button" "QC rules" is "be.visible"
And I can "create" the field constraint rule with fields
| Table1 | Field1 | blocker Test | testName | Field type NUMBER | Message Info | Blocker |
And I can "Create" a "Field comparison" with a "" with fields
 | false  | AND | Number | <= | 100  |
And I wait for enter
And the code rule "blocker Test" is "be.visible" on the list of rules

# REP-1312
Scenario: f) As a data custodian I want to be able to set a design dataset as reference dataset

Given I'm logged at Reportnet page as 'userCustodian'
When I filter the dataflow list by "name" with "Dataflow Reportnet Testing"
And I click on "Dataflow Reportnet Testing"
Then I can click on element "New schema"
And I can create a dataset schema public available with name "Reference data"
And Confirm new dataset schema creation is visible
And I can click on element "Reference data"
And I can fill a dataset schema with name "Information", description "description Information" and with following fields
 | code  | description 1 | Text | | true |
 | label | description 2 | Text | | true |
And I change to "Tabular data" mode
And I can add a record 
| 1 | test1 |
And I can add a record 
| 2 | test2 |
And I set the design dataset as "Reference dataset"
# And I set the design dataset as "Available in public view"
And the "button" "External integrations" is "be.disabled"
And the "fieldsDesigner" "Read only" is "checked"
And the "fieldsDesigner" "Read only" is "be.disabled"
And the "fieldsDesigner" "Prefilled" is "checked"
And the "fieldsDesigner" "Prefilled" is "be.disabled"
And the "button" "Configure webform" is "be.disabled"

#REP-457
Scenario: g) As a data custodian I can fill a read only (and prefill) dataset schema 

Given I'm logged at Reportnet page as 'userCustodian'
When I filter the dataflow list by "name" with "Dataflow Reportnet Testing"
And I click on "Dataflow Reportnet Testing"
And I can click on element "DS-Test"
Then I can fill a dataset schema with name "Table2", description "description Table2" and with following fields
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
Then I can "add" a Data provider with Representative of "All countries: EEA member countries PLUS other countries and territories" and account "test.provider@abc.com" and Data provider "Spain"
And I can click on element "Manage lead reporters"
And I can "addToCountry" a Data provider with Representative of "All countries: EEA member countries PLUS other countries and territories" and account "testleadreporter@reportnet.net" and Data provider "Spain"
And I can click on element "Manage lead reporters"
And I can "addMore" a Data provider with Representative of "All countries: EEA member countries PLUS other countries and territories" and account "test.provider@abc.com" and Data provider "France"
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
And I wait for notification
And I wait for notification
And I see the message: "SUCCESS"
And I reload the page
And I click on "Dataflow Reportnet Testing"
And I reload the page
And I can click on element "Test dataset"
And I reload the page
And the "action" "Test Dataset - DS-Test" is "be.visible"
And the "action" "Test Dataset - DS2" is "be.visible"
And I can go to the dataflow page
And I can click on element "Test dataset"
And I can click on element "Test Dataset - DS-Test"
And I wait for enter
Then I can add a record 
| 101 | |
And I wait for enter
And I delete the dataset table row 1
And I can go to the dataflow page
And I can click on element "Technical feedback"
When I select the country "Spain" 
Then I can "send" the message "Test communication"
And I can "send" the message "Test message"


Scenario Outline: ka) As a Reportnet User I can change the application date format

Given  I'm logged at Reportnet3 page as "userDLHProvider"
And I wait for enter
When I filter the dataflow list by "name" with "Dataflow Reportnet Testing"
And I can see the dateFormat on the "<dataflow>" as "<oldDate>"
Then I can see the user profile page
And I can change the visual "<option>" from "<fromFormat>" to "<toFormat>"
And the "action" "Dataflows" is "be.visible"
And I can see the dateFormat on the "<dataflow>" as "<newDate>"

Examples:
  | option     | fromFormat | toFormat   | dataflow                   | oldDate    | newDate    |
  | dateFormat | YYYY-MM-DD | DD-MM-YYYY | Dataflow Reportnet Testing | YYYY-MM-DD | DD-MM-YYYY |

# REP-191
Scenario: l) As a Reportnet User I can change the default rows per page

Given  I'm logged at Reportnet3 page as "userDLHProvider"
And I wait for enter
When I filter the dataflow list by "name" with "Dataflow Reportnet Testing"
And I can click on "Dataflow Reportnet Testing"
And I can click on element "Spain"
And I can click on element "DS-Test"
And the "button" "Import table data" is "be.enabled"
And I import a file "testPagination.csv"
And I wait for enter
And I reload the page
And I am in "DS-Test" dataset
And the dataset table "Table1" has 5 records
And I can see the user profile page
Then I can change the visual rows to "10"
And the "action" "Dataflows" is "be.visible"
And I filter the dataflow list by "name" with "Dataflow Reportnet Testing"
And I can click on "Dataflow Reportnet Testing"
And I can click on element "Spain"
And I can click on element "DS-Test"
And the dataset table "Table1" has 10 records


# REP-1027 
Scenario: n) As a data provider I don't have access to these new datasets

Given I'm logged at Reportnet3 page as "userDLHProvider"
When I filter the dataflow list by "name" with "Dataflow Reportnet Testing"
And I wait for enter
And I click on "Dataflow Reportnet Testing"
Then the "button" "Test dataset" is "not.exist"


# REP-816
Scenario: p) As a data custodian I can export EU Datasets

Given I'm logged at Reportnet page as 'userCustodian'
And I wait for enter
When I filter the dataflow list by "name" with "Dataflow Reportnet Testing"
And I click on "Dataflow Reportnet Testing"
And I wait for enter
Then I can click on element "Export EU datasets"

#REP-457
Scenario: q) As a data provider I cannot modify a read only table

Given I'm logged at Reportnet3 page as "userDLHProvider"
When I filter the dataflow list by "name" with "Dataflow Reportnet Testing"
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
Scenario: r) As a data provider I can see the prefilled table

Given I'm logged at Reportnet3 page as "userDLHProvider"
And I wait for enter
When I filter the dataflow list by "name" with "Dataflow Reportnet Testing"
And I click on "Dataflow Reportnet Testing"
And I can click on element "Spain"
And I can click on element "DS-Test"
Then the dataset table "Table3" has 2 records

#REP-944
Scenario: s) As a custodian, I want to be able to communicate with lead reporters of a country.

Given I'm logged at Reportnet page as 'userCustodian'
When I filter the dataflow list by "name" with "Dataflow Reportnet Testing"
And I wait for enter
And I click on "Dataflow Reportnet Testing"
And I can click on element "Technical feedback"
When I select the country "Spain" 
Then I can "send" the message "Test communication"
And I can "send" the message "Test message"

#REP-1314
Scenario: t) As a custodian, I can delete a message

Given I'm logged at Reportnet page as 'userCustodian'
When I filter the dataflow list by "name" with "Dataflow Reportnet Testing"
And I click on "Dataflow Reportnet Testing"
And I can click on element "Technical feedback"
When I select the country "Spain"
Then I can "delete" the message "Test message" 


#REP-1314
Scenario: u) As a custodian, I can attach a file

Given I'm logged at Reportnet page as 'userCustodian'
When I filter the dataflow list by "name" with "Dataflow Reportnet Testing"
And I click on "Dataflow Reportnet Testing"
And I can click on element "Technical feedback"
When I select the country "Spain" 
And the "button" "Attach file" is "be.enabled"
Then I import a file "importLeadReporters.csv"

# REP-1839
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

Given I'm logged at Reportnet3 page as "userDLHProvider"
When I filter the dataflow list by "name" with "Dataflow Reportnet Testing"
And I click on "Dataflow Reportnet Testing"
Then the "Dashboards" is "visible"

  Examples: 
  | visibility_status     | 
  | visible               | 

Scenario: z) As a data custodian I see the Validation dashboards and Release status

Given I'm logged at Reportnet page as 'userCustodian'
When I filter the dataflow list by "name" with "Dataflow Reportnet Testing"
And I click on "Dataflow Reportnet Testing"
And I can click on element "Dashboards"
Then I can see the Release status dashboard and Validation dashboards

# REP-1192 REP-1312 REP-1432 REP-1275
Scenario Outline: za) As a public user I can see the list of all dataflows marked as publicly available

Given I'm in Reportnet page
And I can click on "View by obligation dataflow"
And I can filter obligation dataflow by "name" with "Dataflow Reportnet Testing"
And I can see for dataflow "Dataflow Reportnet Testing" the instrument "Air Quality Directive IPR", status "Open"
And I can see the information on "Dataflow Reportnet Testing" with "<country>" "<type>" "<technicalAcceptance>"
And I'm logged at Reportnet page as "userCustodian"

 Examples: 
    | country            | type                 | technicalAcceptance |
    | Finland            | not released         |                     |
    | France             | not released         |                     |
    | Spain              | not released         |                     |
    | Reference datasets | reference data       |                     |
    | Finland            | technical acceptance |                     |
    | France             | technical acceptance | Pending             |
    | Spain              | technical acceptance | Pending             |


Scenario Outline: zc) As a Data Custodian I can see the roles on the dataflow list

Given I'm logged at Reportnet page as 'userCustodian'
Then I can see the "<role>" on "Dataflow Reportnet Testing"

  Examples:
    | role      |
    | CUSTODIAN |


Scenario Outline: zd) As a Data Data Provider I can see the roles on the dataflow list

Given I'm logged at Reportnet3 page as "userDLHProvider"
Then I can see the "<role>" on "Dataflow Reportnet Testing"

  Examples:
    | role      |
    | CUSTODIAN  |

#REP-822
Scenario: ze) As a reporter, I can see the status of the dataflows

Given I'm logged at Reportnet3 page as "userDLHProvider"
When I filter the dataflow list by "name" with "Dataflow Reportnet Testing"
Then I see the "Delivery status" on "Dataflow Reportnet Testing"

# REP-1210
Scenario Outline: zf) As a custodian, I can Close/open release process

Given I'm logged at Reportnet page as 'userCustodian'
When I filter the dataflow list by "name" with "Dataflow Reportnet Testing"
And I can see the "<status>" on "<dataflow>"
And I click on "Dataflow Reportnet Testing"
And I wait for enter
And the "action" "Releasing status" is "be.visible"
When I click the check to "<action>" the reporting
And I can go to the list dataflows page
And I can see the "<nextStatus>" on "<dataflow>"
And The user logout
And I'm logged at Reportnet3 page as 'userDLHProvider'
When I filter the dataflow list by "name" with "Dataflow Reportnet Testing"
And I click on "Dataflow Reportnet Testing"
And I can click on element "Spain"
Then the button "Release to data collection" is "<visibility>"

  Examples:
    | status | nextStatus | dataflow                   | action | visibility  |
    | OPEN   | CLOSED     | Dataflow Reportnet Testing | close  | visible     |
    | CLOSED | OPEN       | Dataflow Reportnet Testing | open   | visible     |

#REP-1367
Scenario: zg) As a requester (custodian/steward), in an open dataflow I am able to create more unique constraints

Given I'm logged at Reportnet page as 'userCustodian'
When I filter the dataflow list by "name" with "Dataflow Reportnet Testing"
And I can click on "Dataflow Reportnet Testing"
And I can click on element "DS-Test"
And the "button" "Unique constraints" is "be.visible"
Then I can add unique constraint on "Table4" with "Field1"
Then the table Unique constraints has 2 records

#REP-413
@sanity
Scenario: zh) As a data provider I can create a API-KEY

Given I'm logged at Reportnet3 page as 'userDLHProvider'
And I wait for enter
When I filter the dataflow list by "name" with "Dataflow Reportnet Testing"
And I click on "Dataflow Reportnet Testing"
And I can click on element "Spain"
And the "action" "API-key" is "be.visible"
Then the "button" "Generate new API-key" is "be.enabled"
And new API-key is created

#REP-1322
Scenario: zi) As a registered user I can export with an option (zip XLSX + attachments)

Given I'm logged at Reportnet page as 'userCustodian'
And I wait for enter
When I filter the dataflow list by "name" with "Dataflow Reportnet Testing"
And I can click on "Dataflow Reportnet Testing"
And I can click on element "Spain"
And I can click on element "DS2"
Then the "button" "Export dataset data" is "be.enabled"
And I can export dataset data "ZIP (.xlsx + attachments)"
And I see the message: "SUCCESS"

#REP-1841
Scenario: zj) As a Lead Reporter I want to be able to assign a Reporter whose email doesn't exist to a Dataflow

Given I'm logged at Reportnet3 page as 'userDLHProvider'
And I wait for enter
When I filter the dataflow list by "name" with "Dataflow Reportnet Testing"
And I can click on "Dataflow Reportnet Testing"
And I can click on element "Spain"
And the "action" "Manage reporters" is "be.visible"
When I can "Add" a editor "temporaryReporter@reportnet.net" with permissions "REPORTER WRITE"
Then I can see a tag next to the invalid reporter email


#REP-2161
Scenario: zk) As a custodian/steward I can enable to automatically delete reporter data and snapshots with technical acceptance of delivery

Given I'm logged at Reportnet page as 'userCustodian'
When I filter the dataflow list by "name" with "Dataflow Reportnet Testing"
And I click on "Dataflow Reportnet Testing"
When the "action" "Automatic delete" is "be.visible"
Then I can check enable automatic delete reporter data and snaphots

#REP-2231
Scenario Outline: zl) As a Custodian I cannot edit a dataflow name

Given I'm logged at Reportnet page as 'userCustodian'
When I filter the dataflow list by "name" with "Dataflow Reportnet Testing"
And I click on "Dataflow Reportnet Testing"
Then I "<action>" a dataflow with name "<dataflowNameEdited>" 

Examples: 
    | dataflowName               | dataflowNameEdited                 | action       |
    | Dataflow Reportnet Testing | Dataflow Reportnet Testing edited  | cannot edit  | 

Scenario Outline: zm) As an Admin I can edit a dataflow name

Given I'm logged at Reportnet page as 'userAdmin'
And I filter the dataflow list by "name" with "Dataflow Reportnet Testing"
And I click on "Dataflow Reportnet Testing"
And the "action" "Edit" is "be.visible"
Then I can "Save" a dataflow with name "Dataflow Reportnet Testing edited"

	
