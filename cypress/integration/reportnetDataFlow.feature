Feature: Reportnet Dataflow - As an existing user on the Repornet system I want to test the actions with dataflow data


Scenario: As a data custodian I can add a new data flow

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And the "action" "Create new dataflow" is "be.visible"
Then I can "Create" a dataflow with name "New Test" and description "new description New Test" and obligation "(C) Information on the assessment regime (Article 7)" with "noFilters"


Scenario: As a data custodian I can edit a data flow

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "New Test"
And the "action" "Edit" is "be.visible"
Then I can "Save" a dataflow with name "Test edited" and description "old description Test2" and obligation "(C) Preliminary information on the assessment regime (Article 7)" with "noFilters"


Scenario Outline: As a Reportnet User I can see the roles on the dataflow list

Given I'm logged at Reportnet page as user "<user>" and password "<password>"
Then I can see the "<role>" on "Dataflow Reportnet Testing"

  Examples: 
    | user          | password | role           | 
    | testprovider  | 1234     | REPORTER       | 
    | testcustodian | 1234     | DATA_CUSTODIAN | 


Scenario Outline: As a Reportnet User I can filter the dataflow list

Given I'm logged at Reportnet page as user "<user>" and password "<password>"
And the dataflow list has 2 items
Then I can filter by "<type>" with "<filter>"
And the dataflow list has <total> items

  Examples: 
    | user          | password | type           | filter         | total |
    | testcustodian | 1234     | name           | reportnet      | 1     |
    | testcustodian | 1234     | description    | dataflow       | 1     |
    | testcustodian | 1234     | status         | DRAFT          | 1     |
    | testcustodian | 1234     | userRole       | DATA_CUSTODIAN | 2     |


Scenario Outline: As a Reportnet User I can clear filters in the dataflow list

Given I'm logged at Reportnet page as user "<user>" and password "<password>"
And the dataflow list has 2 items
Then I can filter by "<type>" with "<filter>"
And the dataflow list has <total> items
Then I can clear "<clear>" filters
And the dataflow list has 2 items

  Examples: 
    | user          | password | type           | filter    | clear          | total |
    | testcustodian | 1234     | name           | reportnet | all            | 1     | 
    | testcustodian | 1234     | name           | reportnet | name           | 1     |
    | testcustodian | 1234     | description    | dataflow  | description    | 1     |


Scenario Outline: As a Reportnet User I can sort the dataflow list

Given I'm logged at Reportnet page as user "<user>" and password "<password>"
And I sort the dataflow list by "<field>"
Then The first dataflow is "<first>" and the last dataflow is "<last>"

  Examples: 
    | user          | password | field          | first                      | last                       |
    | testcustodian | 1234     | name           | Dataflow Reportnet Testing | Test edited                |
    | testcustodian | 1234     | description    | Dataflow Reportnet Testing | Test edited                |
    | testcustodian | 1234     | status         | Test edited                | Dataflow Reportnet Testing |
    | testcustodian | 1234     | userRole       | Test edited                | Dataflow Reportnet Testing |


Scenario: As a data custodian I can delete a data flow

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "Test edited"
And the "action" "Edit" is "be.visible"
Then I can delete the dataflow "Test edited"
And I see the message: "SUCCESS"


#REP-413
@sanity
Scenario: As a data provider I can create a API-KEY

Given I'm logged at Reportnet page as user "testprovider" and password "1234"
And I can click on "Dataflow Reportnet Testing"
And I can click on element "Spain"
And the "action" "API-key" is "be.visible"
Then the "button" "Generate new API-key" is "be.enabled"
And new API-key is created
