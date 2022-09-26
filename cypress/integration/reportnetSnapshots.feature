Feature: Reportnet Snapshots - As an existing user on the Repornet system I want to test the actions with Save Copy

@sanity
Scenario: As a data custodian I can add a new data flow

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And the "action" "Create new dataflow" is "be.visible"
Then I can "Create" a dataflow with name "Snapshot dataflow Test" and description "Snapshot dataflow Test" and obligation "(C) Information on the assessment regime (Article 7)" with "noFilters"
And I can click on "Snapshot dataflow Test"
And I can click on element "New schema"
And I can "create" a dataset schema with name "DS-Test"
And I can click on "DS-Test"
Then I can fill a dataset schema with name "Table1", description "description Table1" and with following fields
 | Field1 | Field 1 description | Number - Integer | | true |
 | Field2 | Field 2 description | Text             | |      |
And I can go to the dataflow page
And I can click on element "Manage lead reporters"
Then I can "add" a Data provider with Representative of "EEA Member countries" and account "testprovider@reportnet.net" and Data provider "Spain"
And I can click on element "Manage lead reporters"
And I can see the representative "Spain" "testprovider@reportnet.net"
And I can go to the dataflow page
And I can click on element "Create data collections"
Then I can create data collections with a technical acceptance step for the reporter submissions and "public"
And I see the message: "SUCCESS"


@sanity
Scenario: As a data provider I can save a copy of a dataset

Given I'm logged at Reportnet page as user "testprovider" and password "1234"
And I can click on "Snapshot dataflow Test"
And I can click on element "DS-Test"
And I click on the tab "Manage copies"
Then I can save a copy with description "New copy"


@sanity
Scenario: As a data provider I can restore a copy of a dataset

Given I'm logged at Reportnet page as user "testprovider" and password "1234"
And I can click on "Snapshot dataflow Test"
And I can click on element "DS-Test"
And I click on the tab "Manage copies"
Then I can "restore" a dataset copy


Scenario: As a data provider I can delete a copy of a dataset

Given I'm logged at Reportnet page as user "testprovider" and password "1234"
And I can click on "Snapshot dataflow Test"
And I can click on element "DS-Test"
And I click on the tab "Manage copies"
And The snapshot list has 1 records
Then I can "delete" a dataset copy
And The snapshot list has 0 records
