Feature: Reportnet Dataflow - As an existing user on the Repornet system I want to test the actions with dataflow data


Scenario: a) As a data custodian I can add a new data flow

Given I'm logged at Reportnet page as "userCustodian"
And the "action" "Create new dataflow" is "be.visible"
Then I "Create" a reporting dataflow with name "New Test" and description "new description New Test" and obligation "(C) Information on the assessment regime (Article 7)" with "noFilters"
And I click on "New Test"
And I can click on element "New schema"
And I can "create" a dataset schema with name "DS-Test"
And I can click on element "DS-Test"
Then I can fill a dataset schema with name "Table1", description "description Table1" and with following fields
 | Field1 | Field 1 description | Number - Integer | | true |


Scenario: b) As a data custodian I can edit a data flow

Given I'm logged at Reportnet page as 'userCustodian'
And I click on "New Test"
And the "action" "Edit" is "be.visible"
Then I can "Save" a dataflow with name "Test edited" and description "old description Test2" and obligation "(C) Preliminary information on the assessment regime (Article 7)" with "noFilters"


#REP-1496
Scenario: e) As a registered user I can import a zip file through an external integration

Given I'm logged at Reportnet page as 'userCustodian'
And I click on "Test edited"
And I can click on element "DS-Test"
And the "button" "External integrations" is "be.visible"
And the "button" "Create external integration" is "be.visible"
Then I can "Create" the new external integration "import"
  | ZIP | ZIP | ReportNetTesting | ImportZIP_test.fmw | IMPORT | zip | p1 | 1 |
And the "button" "Close" is "be.visible"
And I click on the tab "Import dataset data"
Then I can see the list of external "imports" with the name "ZIP (.zip)"
And I can click on the list element with the name "ZIP (.zip)"
And I import a "zip" file "DS-Test.zip"
Then I see the message: "SUCCESS"
And the "action" "Notifications" is "be.visible"
Then I see the notification "Loaded data completed at DS-Test" in the notification received list


Scenario: f) As a data custodian I can delete a data flow

Given I'm logged at Reportnet page as 'userCustodian'
And I click on "Test edited"
And the "action" "Edit" is "be.visible"
Then I can delete the dataflow "Test edited"
And I see the message: "SUCCESS"

#REP-1438 REP-1605
Scenario: g) As a custodian/steward, I want to be able to create a Reference dataflow.

Given I'm logged at Reportnet page as 'userCustodian'
And I can click on "Reference dataflows"
And the "action" "Create new dataflow" is "be.visible"
And I "Create" a reference dataflow with name "Reference dataflow" and description "new description Reference Test"
When I filter the dataflow list by "name" with "Reference dataflow"
And I click on "Reference dataflow"
And I can click on element "New schema"
And I can "create" a dataset schema with name "DS-Reference-Test"
And I can click on element "DS-Reference-Test"
Then I can fill a dataset schema with name "Table1", description "description Table1" and with following fields
  | code  | code description  | Number - Integer |  | true  |
  | label | label description | Text             |  | false |
And I can fill a dataset schema with name "Table2", description "description Table2" and with following fields
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


Scenario: h) As a custodian I want to be able to filter reference dataflows

Given I'm logged at Reportnet page as 'userCustodian'
And I can click on "Reference dataflows"
And I can filter by "name" with "Reference dataflow"
And I can click on "Reference dataflow"

#REP-1438
Scenario: i) As a custodian/steward, I want to be able to update data in a reference dataset if it is marked as updatable.

Given I'm logged at Reportnet page as 'userCustodian'
And I can click on "Reference dataflows"
And I can filter by "name" with "Reference dataflow"
And I click on "Reference dataflow"
And I can click on element "DS-Reference-Test"
And I "can not" update the cell with the text "test1" to the text "test4" in a "reference dataset"
And the "action" "Update status" is "be.visible"
When I "Unlock" the reference dataset
And I "can" update the cell with the text "test1" to the text "test4" in a "reference dataset"
And the "action" "Update status" is "be.visible"
Then I "Lock" the reference dataset
And I "can not" update the cell with the text "test2" to the text "test4" in a "reference dataset"


Scenario: j) As a custodian, I want to be able to create a Citizen and science dataflow.

Given I'm logged at Reportnet page as 'userCustodian'
And I can click on tab "Citizen science dataflows"
And the "action" "Create new dataflow" is "be.visible"
Then I "Create" a citizen dataflow with name "Citizen test dataflow" and description "new description Citizen Test" and obligation "(C) Information on the assessment regime (Article 7)" with "noFilters"


#REP-1647
Scenario: k) As an admin, I want to be able to see all dataflows.

Given I'm logged at Reportnet page as 'userAdmin'
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




