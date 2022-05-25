Feature: Reportnet Dataset Schemas - As an existing user on the Repornet system I want to test the Dataset Schemas page

Scenario Outline: As a Reportnet User I can see Dataset Schemas to dataflow

Given I'm logged at Reportnet page as user "<user>" and password "<password>"
And I can click on "Dataflow Reportnet Testing"
And I can click on element "Dataflow help"
And I can click on the tab "Dataset schemas"
Then I can see the dataset schema "<datasetName>"

   Examples: 
    | user          | password | datasetName |
    | testprovider  | 1234     | D S- Test   |
    | testcustodian | 1234     | D S- Test   |


Scenario Outline: As a data custodian I can see Dataset Schemas to dataflow

Given I'm logged at Reportnet page as user "<user>" and password "<password>"
And I can click on "Dataflow Reportnet Testing"
And I can click on element "Dataflow help"
And I can click on the tab "Dataset schemas"
Then I can see the dataset schema "<datasetName>"
And I can see the dataset schema "<tableSchemaName>"
And I can see the dataset schema "<tableFields>"

   Examples: 
    | user          | password | datasetName  | tableSchemaName | tableFields     |
    | testcustodian | 1234     | D S- Test    | Table1          | Field 1,Field 2 |


@sanity
Scenario: As a data custodian I can create new dataflow and dataset schema

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And the "action" "Create new dataflow" is "be.visible"
And I can "Create" a dataflow with name "DatasetSchema Test" and description "Description New Test" and obligation "(C) Information on the assessment regime (Article 7)" with "noFilters"
And I can click on "DatasetSchema Test"
Then I can click on element "New schema"
And I can "create" a dataset schema with name "DS-Test"
And I can click on "DS-Test"


@sanity
Scenario: As a data custodian I can rename a dataset schema

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "DatasetSchema Test"
And I can "rename" a dataset schema with name "DS-Test2"
Then I can click on "DS-Test2"


Scenario: No dashboard when there is no data

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "DatasetSchema Test"
And I can click on element "DS-Test2"
Then the "button" "Dashboards" is "be.disabled"


@sanity
Scenario: As a data custodian I can fill a dataset schema

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "DatasetSchema Test"
And I can click on element "DS-Test2"
Then I can fill a dataset schema with name "Table1", description "description Table1" and with following fields
 | table1f1 | description 1 | Number - Integer | | true  |
And I change to "view" mode
And I can add a record 
 |1|
And I can add a record 
 |2|
And I can add a record 
 |3|


@sanity
Scenario: As a data custodian I can fill a dataset schema with a single select

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "DatasetSchema Test"
And I can click on element "DS-Test2"
Then I can fill a dataset schema with name "Table2", description "description Table2" and with following fields
 | table2f1 | description 1 | Single select    | Yes,No,N/A |       |
 | table2f2 | description 1 | Number - Integer |            | true  |


@sanity
Scenario: As a data custodian I can check a field as a pk

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "DatasetSchema Test"
And I can click on element "DS-Test2"
Then I can fill a dataset schema with name "Table3", description "description Table3" and with following fields
 | table3f1 | description 1 | Number - Integer |            | true  |
 | table3f2 | description 2 | Single select    | Yes,No,N/A | false |


@sanity
Scenario: As a data custodian I can fill a dataset schema with a link

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "DatasetSchema Test"
And I can click on element "DS-Test2"
Then I can fill a dataset schema with name "Table4", description "description Table4" and with following fields
 | table4f1 | description 1 | Link | 
And I can define a field as a foreign key to table "Table1 - table1f1"
And I change to "view" mode
And I can add a record 
|1| link |


# REP-461  REP-582
@sanity
Scenario: As a data custodian I can fill a dataset schema with a URL, Phone Number, Attachment

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "DatasetSchema Test"
And I can click on element "DS-Test2"
Then I can fill a dataset schema with name "Table5", description "description Table5" and with following fields
 | table5f1 | description 1 | Number - Integer |             | true  |
 | table5f2 | description 2 | Number - Decimal |             | false |
 | table5f3 | description 3 | URL              |             | false |
 | table5f4 | description 4 | Email            |             | false |
 | table5f5 | description 5 | Phone number     |             | false |
 | table5f6 | description 6 | Attachment       | pdf,txt,csv | false |


# REP-580
@sanity
 Scenario: As a data custodian I can manage UNIQUE constraints in tables

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "DatasetSchema Test"
And I can click on element "DS-Test2"
When I can click on "Add unique constraint"
And I can create a unique constraint with table "Table3" and field "table3f2"
Then I can click on "Unique constraints"
And the unique constraint "table3f2" is "be.visible" on the list


# REP-696
Scenario: As a Custodian, I want to clone all schemas from other dataflow (from my dataflows)
Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "DatasetSchema Test"
And I can click on element "New schema"
And I can "clone" a dataset schema with name "Dataflow Reportnet Testing"
When I see the message: "SUCCESS"
Then I can click on element "CLONE_DS-Test"


Scenario: As a data custodian I can delete a dataset schema

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "DatasetSchema Test"
And I can "delete" a dataset schema with name "DS-Test2"
Then the "button" "DS-Test2" is "not.visible"


Scenario: As a data custodian I can delete a data flow

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "DatasetSchema Test"
And the "action" "Edit" is "be.visible"
Then I can delete the dataflow "DatasetSchema Test"
