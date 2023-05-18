Feature: Reportnet Snapshots - As an existing user on the Repornet system I want to test the actions with Save Copy

@sanity
Scenario: a) As a data custodian I can add a new data flow

Given I'm logged at Reportnet page as "userCustodian"
And the "action" "Create new dataflow" is "be.visible"
Then I "Create" a reporting dataflow with name "Snapshot dataflow Test" and description "Snapshot dataflow Test" and obligation "(C) Information on the assessment regime (Article 7)" with "noFilters"
And I click on "Snapshot dataflow Test"
And I can click on element "New schema"
And I can create a dataset schema public available with name "DS-Test"
And Confirm new dataset schema creation is visible
And I can click on element "DS-Test"
And I can fill a dataset schema with name "Table1", description "description Table1" and with following fields
 | Field1 | Field 1 description | Number - Integer | | true |
 | Field2 | Field 2 description | Text             | |      |
And I can go to the dataflow page
And I can click on element "Manage lead reporters"
Then I can "add" a Data provider with Representative of "All countries: EEA member countries PLUS other countries and territories" and account "test.provider@abc.com" and Data provider "Spain"
And I can click on element "Manage lead reporters"
And I can see the representative "Spain" "test.provider@abc.com"
And I click on close button
And I can go to the dataflow page
And the "action" "Manage requesters" is "be.visible"
When I can "Add" a editor "test.provider@abc.com" with permissions "CUSTODIAN"


@sanity
Scenario: b) As a data provider I can save a copy of a dataset

Given I'm logged at Reportnet page as "userProvider"
And I click on "Snapshot dataflow Test"
And I can click on element "DS-Test"
And I click on the tab "Manage copies"
Then I can save a copy with description "New copy"


@sanity
Scenario: c) As a data provider I can restore a copy of a dataset

Given I'm logged at Reportnet page as "userProvider"
And I click on "Snapshot dataflow Test"
And I can click on element "DS-Test"
And I click on the tab "Manage copies"
Then I can "restore" a dataset copy


Scenario: d) As a data provider I can delete a copy of a dataset

Given  I'm logged at Reportnet page as "userProvider"
And I click on "Snapshot dataflow Test"
And I can click on element "DS-Test"
And I click on the tab "Manage copies"
And The snapshot list has 1 records
Then I can "delete" a dataset copy
And The snapshot list has 0 records
