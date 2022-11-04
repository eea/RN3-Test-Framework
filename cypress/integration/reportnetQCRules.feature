Feature: Reportnet QC Rules - As an existing user on the Repornet system I want to test the actions with QC Rules

@sanity
Scenario: As a data custodian I can add a new data flow with DS

Given I'm logged at Reportnet page as "userCustodian"
And the "action" "Create new dataflow" is "be.visible"
Then I "Create" a reporting dataflow with name "New Dataflow Rules Test" and description "Description New Dataflow Rules Test" and obligation "(C) Information on the assessment regime (Article 7)" with "noFilters"
And I click on "New Dataflow Rules Test"
And I can click on element "New schema"
And I can "create" a dataset schema with name "DS-Test"
And I can click on element "DS-Test"
And I can fill a dataset schema with name "Table1", description "description Table1" and with following fields
  | Field1 | description 1 | Number - Integer |  | true |
And I can fill a dataset schema with name "Table2", description "description Table2" and with following fields
  | Field1 | description 1 | Text |  | false |
  | Field2 | description 2 | Text |  | false |


#REP-1408 REP-1437

Scenario: As a data custodian in desing dataset and table is marked as mandatory, an automatic QC is created and will be blocker

Given I'm logged at Reportnet page as "userCustodian"
And I click on "New Dataflow Rules Test"
And I can click on element "DS-Test"
And the "button" "QC rules" is "be.visible"
When I can filter QCs by "table" with "Table1"
And I can filter QCs by "levelError" with "BLOCKER"
Then the code rule "Mandatory table records check" is "be.visible" on the list of rules
And I reload the page
And I mark the table as a "not mandatory table"
And I reload the page
And the "fieldsDesigner" "Mandatory" is "not.be.checked"


#REP-384 REP-459
@sanity
Scenario: As a data custodian I can create new field constraint QC Rules (quotes control on inputs)

Given I'm logged at Reportnet page as "userCustodian"
And I click on "New Dataflow Rules Test"
And I can click on element "DS-Test"
And the "button" "QC rules" is "be.visible"
Then I can "create" the field constraint rule with fields
  | Table1 | Field1 | qc1 'Test' | test "Name" | Field type "NUMBER" | Message "Info" | ERROR |
And I can "Create" a "Field comparison" with a "group" with fields
  | true  | AND | Number | >= | 2  |
  | false | AND | Number | <= | 10 |
And the code rule "qc1 'Test'" is "be.visible" on the list of rules
And the new qc rule "qc1 'Test'" is "correct"


#REP-384
@sanity
Scenario: As a data custodian I can validate the fields with the new rule (quotes control on inputs)

Given I'm logged at Reportnet page as "userCustodian"
And I click on "New Dataflow Rules Test"
And I can click on element "DS-Test"
And I change to "Tabular data" mode
And I can add a record
  | 1 |  |
And I can add a record
  | 6 |  |
Then the "button" "Validate" is "be.enabled"
And I see the message: "SUCCESS"
And I reload the page
And I can see the field "Field1" has 2 error


# REP-1395
Scenario: As a user, I want to be able to download the validation information (QC checks results grouped).

Given I'm logged at Reportnet page as "userCustodian"
And I click on "New Dataflow Rules Test"
And I can click on element "DS-Test"
And the "button" "Show validations" is "be.visible"
And the "button" "Download validations" is "be.visible"
Then I can click on "Download validations"
And I see the message: "SUCCESS"


#REP-431 REP-1129
Scenario: As a data custodian I can edit QC Rules

Given I'm logged at Reportnet page as "userCustodian"
And I click on "New Dataflow Rules Test"
And I can click on element "DS-Test"
And the "button" "QC rules" is "be.visible"
Then I can filter QCs by "field" with "Field1"
And the qcRules list has 3 items
And the code rule "qc1" is "be.visible" on the list of rules
Then I can "edit" the field constraint rule with fields
  | Table1 | Field1 | qc1-2 | testNameEdited | Field type NUMBER edited | Message Info edited | INFO |
And I can "Update" a "Field comparison" with a "group" with fields
  | false | AND | Number | != | 3 |
And the code rule "qc1-2" is "be.visible" on the list of rules
And the qcRules list has 3 items
   

#REP-1644 #REP-1837
Scenario: As a data custodian I want to include SQL fields in a message

Given I'm logged at Reportnet page as "userCustodian"
And I click on "New Dataflow Rules Test"
And I can click on element "DS-Test"
And the "button" "QC rules" is "be.visible"
Then I can click on "Create table constraint"
And I can "create" a row constraint with fields
  | Table1 | SQLMsgTable | SQLMsgTable | Table SQL constraint | Value: {%field1%} doesn't match the rule requirements | WARNING |
And I can "Create" a table relation "SQL sentence" with fields
  | select * from table1 where field1 > 5 |
And I see the message: "SUCCESS"
When I can "create" the field constraint rule with fields
  | Table1 | Field1 | SQLMsgTest | SQL Name | SQL Info | Value: {%field1%} doesn't match the rule requirements | WARNING |
And I can "Create" a table relation "SQL sentence" with fields
  | select * from table1 where field1 > 5 |
And I see the message: "SUCCESS"
And the "button" "Validate" is "be.enabled"
And I see the message: "Validation finished at DS-Test (DESIGN)"
And I reload the page
And I change to "Tabular data" mode
And I can see the field "Field1" has 4 error
And the "button" "Show validations" is "be.visible"
Then the code rule "SQLMsgTable" with message "Value: 6 doesn't match the rule requirements" is visible on the list of validations
Then the code rule "SQLMsgTest" with message "Value: <field1> doesn't match the rule requirements" is visible on the list of validations


# REP-460
Scenario Outline: As a data custodian I can filter QC Rules

Given I'm logged at Reportnet page as "userCustodian"
And I click on "New Dataflow Rules Test"
And I can click on element "DS-Test"
And the "button" "QC rules" is "be.visible"
Then I can filter QCs by "<type>" with "<filter>"
And the qcRules list has <total> items

Examples:
   | type        | filter | total |
   | levelError  | INFO   | 1     |


Scenario Outline: As a data custodian I can filter QC Rules

Given I'm logged at Reportnet page as "userCustodian"
And I click on "New Dataflow Rules Test"
And I can click on element "DS-Test"
And the "button" "QC rules" is "be.visible"
Then I can filter QCs by "<type>" with "<filter>"
And the qcRules list has <total> items

Examples:
   | type        | filter | total |
   | searchInput | number | 2     |

# REP-384
Scenario: As a data custodian I can delete a QC Rule

Given I'm logged at Reportnet page as "userCustodian"
And I click on "New Dataflow Rules Test"
And I can click on element "DS-Test"
And the "button" "QC rules" is "be.visible"
And the code rule "SQLMsgTest" is "be.visible" on the list of rules
Then I can delete the rule "SQLMsgTest"
And the code rule "SQLMsgTest" is "not.exist" on the list of rules


# REP-292
@sanity
Scenario: As a data custodian I can create Row QC Rule

Given I'm logged at Reportnet page as "userCustodian"
And I click on "New Dataflow Rules Test"
And I can click on element "DS-Test"
Then I can click on "Add row constraint"
And I can "create" a row constraint with fields
  | Table2 | rc1 | testName | Ignore case | Message Info | Warning |
And I can "Create" a expression with fields
  | Field1 | String | =(Ignore case) | field | Field2 |
And the "button" "QC rules" is "be.visible"
And the code rule "rc1" is "be.visible" on the list of rules


# REP-694
@sanity
Scenario: As a data custodian I can create table constraint

Given I'm logged at Reportnet page as "userCustodian"
And I click on "New Dataflow Rules Test"
And I can click on element "DS-Test"
And the "button" "QC rules" is "be.visible"
Then I can click on "Create table constraint"
And I can "create" a row constraint with fields
  | Table2 | ds1 | testName | Table constraint | Message Info | Warning |
And I can "Create" a table relation "Dataset comparison" with fields
  | DS-Test | Table1 | Field1 | Field1 |
And the code rule "ds1" is "be.visible" on the list of rules


# REP-874 

Scenario: As a Custodian, I want to be able to create QCs based on SQL sentences

Given I'm logged at Reportnet page as "userCustodian"
And I click on "New Dataflow Rules Test"
And I can click on element "DS-Test"
And the "button" "QC rules" is "be.visible"
Then I can click on "Create table constraint"
And I can "create" a row constraint with fields
  | Table2 | sqlRule | testName | SQL Info | Message Info | Warning |
And I can "Create" a table relation "SQL sentence" with fields
  | select * from Table1 |
And the code rule "sqlRule" is "be.visible" on the list of rules


# REP-930 

Scenario: As a custodian, I want to validate SQL QCs with a button in the list of Qcs (correct SQLs)

Given I'm logged at Reportnet page as "userCustodian"
And I click on "New Dataflow Rules Test"
And I can click on element "DS-Test"
And the "button" "QC rules" is "be.visible"
When I can click on "Validate QCs"
And I see the message: "SUCCESS"


# REP-1580

Scenario: As a user, I want to download QC list in CSV

Given I'm logged at Reportnet page as "userCustodian"
And I click on "New Dataflow Rules Test"
And I can click on element "DS-Test"
And the "button" "QC rules" is "be.visible"
When I can click on "Download QCs"
And I see the message: "SUCCESS"


# REP-930

Scenario: As a custodian, I want to validate SQL QCs with a button in the list of Qcs (incorrect SQLs)

Given I'm logged at Reportnet page as "userCustodian"
And I click on "New Dataflow Rules Test"
And I can click on element "DS-Test"
And the "button" "QC rules" is "be.visible"
Then I can click on "Create table constraint"
And I can "create" a row constraint with fields
  | Table2 | sqlIncorrectRule | testName | SQL Info | Message Info | Warning |
And I can "Create" a table relation "SQL sentence" with fields
  | select * from |
And the code rule "sqlIncorrectRule" is "be.visible" on the list of rules
When I can click on "Validate QCs"
And I see the message: "The rule sqlIncorrectRule is not valid"


# REP-930

Scenario: As a custodian, I want to see a warning when I am going to create the data collection in case I have invalid QCs and/or disabled Qcs

Given I'm logged at Reportnet page as "userCustodian"
And I click on "New Dataflow Rules Test"
And I can click on element "Manage lead reporters"
Then I can "add" a Data provider with Representative of "EEA Member countries" and account "test.provider@abc.com" and Data provider "Spain"
And I can click on element "Create data collections"
Then I can create data collections with a technical acceptance step for the reporter submissions and "no public"



# REP-2038

Scenario: As a custodian, I want to know the total cost of a SQL QC

Given I'm logged at Reportnet page as "userCustodian"
And I click on "New Dataflow Rules Test"
And I can click on element "DS-Test"
And the "button" "QC rules" is "be.visible"
Then I can click on "Create field constraint"
When I can "create" the field constraint rule with fields
  | Table2 | Field1 | SQLEvaluate | SQL Evaluate | SQL Info | Evaluate rule test | INFO |
And I can "Evaluate" a table relation "SQL sentence" with fields
  | SELECT |


# REP-2045

Scenario: As a custodian, I want to run a SQL QC

Given I'm logged at Reportnet page as "userCustodian"
And I click on "New Dataflow Rules Test"
And I can click on element "DS-Test"
And the "button" "QC rules" is "be.visible"
Then I can click on "Create field constraint"
When I can "create" the field constraint rule with fields
  | Table2 | Field1 | SQLRun | SQL Run | SQL Info | Run rule test | INFO |
And I can "Run" a table relation "SQL sentence" with fields
  | SELECT |


# REP-2041

Scenario: As a data custodian I can see the geometry error generated by ST_TRANSFORM

Given I'm logged at Reportnet page as "userCustodian"
And I click on "New Dataflow Rules Test"
And I can click on element "DS-Test"
And I can fill a dataset schema with name "Table3", description "description Table3" and with following fields
  | location_area | geometry | Multiple polygons |  | false |
And I change to "Tabular data" mode
And the "button" "Import table data" is "be.enabled"
When I check replace data
And I import a file "geom.csv"
And I see the message: "SUCCESS"
Then the "button" "Validate" is "be.enabled"
And I see the message: "SUCCESS"
And I reload the page
And the "button" "Show validations" is "be.visible"
Then the code rule "" with message "Unsupported SRID" is visible on the list of validations
Then the code rule "" with message "The value does not follow the expected syntax for a valid multipolygon <reason>" is visible on the list of validations


Scenario: As a data custodian I can delete a data flow

Given I'm logged at Reportnet page as "userCustodian"
And I click on "New Dataflow Rules Test"
And the "action" "Edit" is "be.visible"
Then I can delete the dataflow "New Dataflow Rules Test"
And I see the message: "SUCCESS"


Scenario: As a data custodian I can add a new data flow with obligations

Given I'm logged at Reportnet page as "userCustodian"
And the "action" "Create new dataflow" is "be.visible"
Then I "Create" a reporting dataflow with name "Rules historic changes Test" and description "Dataflow document test" and obligation "(C) Information on the assessment regime (Article 7)" with "noFilters"
And I click on "Rules historic changes Test"
And I can click on element "New schema"
And I can "create" a dataset schema with name "DS-Test"
Then I can click on element "DS-Test"
And publicly available check is "not.be.disabled"
And I can toggle publicly available check
Then I can fill a dataset schema with name "Table1", description "description Table1" and with following fields
 | Field1 | Field 1 description | Number - Integer | | true |
 | Field2 | Field 2 description | Text             | |      |
And I can go to the dataflow page
And I can click on element "Manage lead reporters"
Then I can "add" a Data provider with Representative of "EEA Member countries" and account "test.provider@abc.com" and Data provider "Spain"
And I can click on element "Manage lead reporters"
And I can see the representative "Spain" "test.provider@abc.com"


Scenario: As a data custodian I can create data collections

Given I'm logged at Reportnet page as "userCustodian"
And I click on "Rules historic changes Test"
And I can click on element "Create data collections"
Then I can create data collections with a technical acceptance step for the reporter submissions and "public"
And I see the message: "SUCCESS"


#REP-384 REP-459
Scenario: As a data custodian I can create new field constraint QC Rules (quotes control on inputs)

Given I'm logged at Reportnet page as "userCustodian"
And I click on "Rules historic changes Test"
And I can click on element "DS-Test"
And the "button" "QC rules" is "be.visible"
Then I can "create" the field constraint rule with fields
  | Table1 | Field1 | qc1 'Test' | test "Name" | Field type "NUMBER" | Message "Info" | ERROR |
And I can "Create" a "Field comparison" with a "group" with fields
  | true  | AND | Number | >= | 2  |
  | false | AND | Number | <= | 10 |
And the code rule "qc1 'Test'" is "be.visible" on the list of rules
And the new qc rule "qc1 'Test'" is "correct"


#REP-431 REP-1129
Scenario: As a data custodian I can edit QC Rules

Given I'm logged at Reportnet page as "userCustodian"
And I click on "Rules historic changes Test"
And I can click on element "DS-Test"
And the "button" "QC rules" is "be.visible"
Then I can filter QCs by "field" with "Field1"
And the qcRules list has 3 items
And the code rule "qc1" is "be.visible" on the list of rules
Then I can "edit" the field constraint rule with fields
  | Table1 | Field1 | qc1-2 | testNameEdited | Field type NUMBER edited | Message Info edited | INFO |
And I can "Update" a "Field comparison" with a "group" with fields
  | false | AND | Number | != | 3 |
And the code rule "qc1-2" is "be.visible" on the list of rules
And the qcRules list has 3 items


#REP-2048 REP-2162
Scenario: As a data custodian I can see the historic changes on each QC

Given I'm logged at Reportnet page as "userCustodian"
And I click on "Rules historic changes Test"
And I can click on element "DS-Test"
And the "button" "QC rules" is "be.visible"
And the code rule "qc1-2" is "be.visible" on the list of rules
Then I can view the historic changes of the rule "qc1-2"
And I can see the history with following fields
    | test.custodian@abc.com | false | true | false |
    | test.custodian@abc.com | true  | true | true  |
