Feature: Reportnet Snapshots - As an existing user on the Repornet system I want to test the actions with Save Copy

@sanity
Scenario: As a data provider I can save a copy of a dataset

Given I'm logged at Reportnet page as user "testprovider" and password "1234"
And I can click on "Dataflow Reportnet Testing"
And I can click on element "Spain"
And I can click on element "DS-Test"
And I can click on the tab "Manage copies"
Then I can save a copy with description "New copy"


@sanity
Scenario: As a data provider I can restore a copy of a dataset

Given I'm logged at Reportnet page as user "testprovider" and password "1234"
And I can click on "Dataflow Reportnet Testing"
And I can click on element "Spain"
And I can click on element "DS-Test"
And I can click on the tab "Manage copies"
Then I can "restore" a dataset copy


Scenario: As a data provider I can delete a copy of a dataset

Given I'm logged at Reportnet page as user "testprovider" and password "1234"
And I can click on "Dataflow Reportnet Testing"
And I can click on element "Spain"
And I can click on element "DS-Test"
And I can click on the tab "Manage copies"
And The snapshot list has 2 records
Then I can "delete" a dataset copy
And The snapshot list has 1 records
