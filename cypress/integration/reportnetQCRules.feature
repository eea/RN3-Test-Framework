Feature: Reportnet QC Rules - As an existing user on the Repornet system I want to test the actions with QC Rules

@sanity
Scenario: As a data custodian I can add a new data flow with DS

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And the "action" "Create new dataflow" is "be.visible"
Then I can "Create" a dataflow with name "New Dataflow Rules Test" and description "Description New Dataflow Rules Test" and obligation "(C) Information on the assessment regime (Article 7)" with "noFilters"
And I can click on "New Dataflow Rules Test"
And I can click on element "New schema"
And I can "create" a dataset schema with name "DS-Test"
And I can click on element "DS-Test"
And I can fill a dataset schema with name "Table1", description "description Table1" and with following fields
 | Field1 | description 1 | Number - Integer | | true  |
And I can fill a dataset schema with name "Table2", description "description Table2" and with following fields
 | Field1 | description 1 | Text | | false |
 | Field2 | description 2 | Text | | false |


#REP-384 REP-459
@sanity
Scenario: As a data custodian I can create new QC Rules

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "New Dataflow Rules Test"
And I can click on element "DS-Test"
And the "button" "QC Rules" is "be.visible"
Then I can "create" the Field Validation rule with fields
| Table1 | Field1 | qc1 | testName | Field type NUMBER | Message Info | Error |
And I can "Create" a "group" with fields
 | true  | AND | Number | >= | 2  |
 | false | AND | Number | <= | 10 |
And the code rule "qc1" is "be.visible" on the list of rules
And the new qc rule "qc1" is "correct"


#REP-384
@sanity
Scenario: As a data custodian I can validate the fields with the new rule

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "New Dataflow Rules Test"
And I can click on element "DS-Test"
And I change to "view" mode
And I can add a record 
|1| |
And I can add a record 
|6| |
Then the "button" "Validate" is "be.enabled"
And I can validate de fields
And I see the message: "SUCCESS"
And I reload the page
And I can see the field "Field1" has 2 error


#REP-431
Scenario: As a data custodian I can edit QC Rules

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "New Dataflow Rules Test"
And I can click on element "DS-Test"
And the "button" "QC Rules" is "be.visible"
And the code rule "qc1" is "be.visible" on the list of rules
Then I can "edit" the Field Validation rule with fields
| Table1 | Field1 | qc1-2 | testNameEdited | Field type NUMBER edited | Message Info edited | INFO |
And I can "Update" a "group" with fields
 | false  | AND | Number | != | 3  |
And the code rule "qc1-2" is "be.visible" on the list of rules


# REP-460
Scenario Outline: As a data custodian I can filter QC Rules

Given I'm logged at Reportnet page as user "<user>" and password "<password>"
And I can click on "New Dataflow Rules Test"
And I can click on element "DS-Test"
And the "button" "QC Rules" is "be.visible"
Then I can filter by "<type>" with "<filter>"
And the qcRules list has <total> items

  Examples: 
    | user          | password | type        | filter    | total |
    | testcustodian | 1234     | levelError  | INFO      | 1     |
    | testcustodian | 1234     | searchInput | number    | 2     |


# REP-384
Scenario: As a data custodian I can delete a QC Rule

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "New Dataflow Rules Test"
And I can click on element "DS-Test"
And the "button" "QC Rules" is "be.visible"
And the code rule "qc1" is "be.visible" on the list of rules
Then I can delete the rule "qc1"
And the code rule "qc1" is "not.be.visible" on the list of rules


# REP-292
@sanity
 Scenario: As a data custodian I can create Row QC Rule

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "New Dataflow Rules Test"
And I can click on element "DS-Test"
Then I can click on "Add row constraint"
And I can "create" a row constraint with fields
| Table2 | rc1 | testName | Ignore case | Message Info | Warning |
And I can "Create" a expression with fields
 | Field1  | String | =(Ignore case) | Field2 |
And the "button" "QC Rules" is "be.visible"
And the code rule "rc1" is "be.visible" on the list of rules


# REP-694
@sanity
Scenario: As a data custodian I can create dataset constraint

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "New Dataflow Rules Test"
And I can click on element "DS-Test"
And the "button" "QC Rules" is "be.visible"
Then I can click on "Create dataset constraint"
And I can "create" a row constraint with fields
| Table2 | ds1 | testName | Dataset constraint | Message Info | Warning |
And I can "Create" a table relation with fields
 | DS-Test | Table1 | Field1 | Field1 |
And the code rule "ds1" is "be.visible" on the list of rules


Scenario: As a data custodian I can delete a data flow

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "New Dataflow Rules Test"
And the "action" "Edit" is "be.visible"
Then I can delete the dataflow "New Dataflow Rules Test"
And I see the message: "SUCCESS"
