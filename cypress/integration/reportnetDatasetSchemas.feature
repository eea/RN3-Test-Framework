Feature: Reportnet Dataset Schemas - As an existing user on the Repornet system I want to test the Dataset Schemas page
@ignore
Scenario Outline: As Data Custodian I can see Dataset Schemas to dataflow

Given I'm logged at Reportnet page as "userCustodian"
And I can click on "Dataset Reportnet Testing"
And I can click on element "Dataflow help"
And I click on the tab "Dataset schemas"
Then I can see the dataset schema "<datasetName>"

Examples:
  | datasetName |
  | DS-Test     |

Scenario Outline: As Data Provider I can see Dataset Schemas to dataflow

Given I'm logged at Reportnet page as "userProvider"
And I can click on "Dataset Reportnet Testing"
And I can click on element "Dataflow help"
And I click on the tab "Dataset schemas"
Then I can see the dataset schema "<datasetName>"

Examples:
  | datasetName |
  | DS-Test     |



@ignore
Scenario Outline: As a data custodian I can see Dataset Schemas to dataflow

Given I'm logged at Reportnet page as "userCustodian"
And I can click on "Dataset Reportnet Testing"
And I can click on element "Dataflow help"
And I click on the tab "Dataset schemas"
Then I can see the dataset schema "<datasetName>"
And I can see the dataset schema "<tableSchemaName>"
And I can see the dataset schema "<tableFields>"

Examples:
  | datasetName | tableSchemaName | tableFields   |
  | DS-Test     | Table1          | Field1,Field2 |


@sanity @ignore
Scenario: As a custodian/steward, I want to be able to create a Reference dataflow.

Given I'm logged at Reportnet page as "userCustodian"
And I can click on "Reference dataflows"
And the "action" "Create new dataflow" is "be.visible"
Then I can "Create" a reference dataflow with name "Reference dataflow 2" and description "new description Reference Test"
And I can click on "Reference dataflow 2"
And I can click on element "New schema"
And I can "create" a dataset schema with name "DS-Reference-Test"
And I can click on element "DS-Reference-Test"
Then I can fill a dataset schema with name "Table1", description "description Table1" and with following fields
  | code  | code description  | Number - Integer |  | true  |
  | label | label description | Text             |  | false |
And I can go to the dataflow page
And I can create reference datasets
And I see the message: "SUCCESS"

@ignore
@sanity
Scenario: As a data custodian I can create new dataflow and dataset schema

Given I'm logged at Reportnet page as "userCustodian"
And the "action" "Create new dataflow" is "be.visible"
And I can "Create" a dataflow with name "DatasetSchema Test" and description "Description New Test" and obligation "(C) Information on the assessment regime (Article 7)" with "noFilters"
And I can click on "DatasetSchema Test"
Then I can click on element "New schema"
And I can "create" a dataset schema with name "DS-Test"
And I can click on "DS-Test"

@ignore
@sanity
Scenario: As a data custodian I can rename a dataset schema

Given I'm logged at Reportnet page as "userCustodian"
And I can click on "DatasetSchema Test"
And I can "rename" a dataset schema with name "DS-Test2"
Then I can click on "DS-Test2"

@ignore
Scenario: No dashboard when there is no data

Given I'm logged at Reportnet page as "userCustodian"
And I can click on "DatasetSchema Test"
And I can click on element "DS-Test2"
Then the "button" "Dashboards" is "be.disabled"

@ignore
@sanity
Scenario: As a data custodian I can fill a dataset schema

Given I'm logged at Reportnet page as "userCustodian"
And I can click on "DatasetSchema Test"
And I can click on element "DS-Test2"
Then I can fill a dataset schema with name "Table1", description "description Table1" and with following fields
  | table1f1 | description 1 | Number - Integer |  | true  |
  | table1f2 | description 2 | Number - Integer |  | false |
And I mark the table as a "prefilled"
And I change to "Tabular data" mode
And I can add a record
  | 1 | 1 |
And I can add a record
  | 2 | 1 |
And I can add a record
  | 3 | 1 |


# REP-212
@ignore
Scenario: As a user I can filter data

Given I'm logged at Reportnet page as "userCustodian"
And I can click on "DatasetSchema Test"
And I can click on element "DS-Test2"
And I change to "Tabular data" mode
And the dataset table "Table1" has 3 records
When I filter by value "3"
Then the dataset table "Table1" has 1 records

# REP-1334
@sanity 
@ignore
Scenario: As a data custodian I can fill a dataset schema with a single select

Given I'm logged at Reportnet page as "userCustodian"
And I can click on "DatasetSchema Test"
And I can click on element "DS-Test2"
Then I can fill a dataset schema with name "Table2", description "description Table2" and with following fields
  | table2f1 | description 1 | Single select    | Yes{enter}No{enter}N/A |      |
  | table2f2 | description 2 | Number - Integer |                        | true |
  | table2f3 | description 3 | Multiple select  | A{enter}B{enter}C      |      |

@ignore
@sanity
Scenario: As a data custodian I can check a field as a pk

Given I'm logged at Reportnet page as "userCustodian"
And I can click on "DatasetSchema Test"
And I can click on element "DS-Test2"
Then I can fill a dataset schema with name "Table3", description "description Table3" and with following fields
  | table3f1 | description 1 | Number - Integer |                        | true  |
  | table3f2 | description 2 | Single select    | Yes{enter}No{enter}N/A | false |


# REP-924
@sanity @ignore
Scenario: As a data custodian I can fill a dataset schema with a link configuring the label of the linked fields and the conditional fields

Given I'm logged at Reportnet page as "userCustodian"
And I can click on "DatasetSchema Test"
And I can click on element "DS-Test2"
Then I can fill a dataset schema with name "Table4", description "description Table4" and with following fields
  | table4f1 | description 1 | Number |
  | table4f2 | description 2 | Link   |
And I can select a "Link" "Table1 - table1f1" with label field "" and linked field "table4f1" and master field "table1f2" and ignore case "" for dataflow ""
And I change to "Tabular data" mode
And I reload the page
And I can add a record
  | 1 | link | 1 |


# REP-145184
@sanity
Scenario: As a data custodian I can ignore case in links tables while filling a dataset schema

Given I'm logged at Reportnet page as "userCustodian"
And I can click on "DatasetSchema Test"
And I can click on element "DS-Test2"
And I can fill a dataset schema with name "Table10", description "description Table10" and with following fields
| table10f1 | description 1 | Text |  | true  |
| table10f2 | description 2 | Text |  | false |
And I change to "Tabular data" mode
And I can add a record
  | key1 | test1 |
And I can add a record
  | key2 | test2 |
And I can fill a dataset schema with name "Table11", description "description Table11" and with following fields
| table11f1 | description 1 | Text |  | true  |
| table11f2 | description 2 | Link |  | false |
And I can select a "Link" "Table10 - table10f1" with label field "table10f2" and linked field "" and master field "" and ignore case "" for dataflow ""
And I change to "Tabular data" mode
And the "button" "Import table data" is "be.enabled"
And I import a file "test3.csv"
And I see the message: "SUCCESS"
And the "button" "Validate" is "be.enabled"
And I see the message: "SUCCESS"
And I reload the page
And I can see the field "Key2" has 2 error
And the "button" "Show validations" is "be.visible"
And the code rule "TC10" with message "The value is not a valid member of the referenced list." is visible on the list of validations
And I can click on the button with text "Close"
And I change to "Design" mode
And I can click on the button with text "Table10 - table10f1"
And I can check on the checkbox ignore case
And I can click on the button with text "Save"
And I change to "Tabular data" mode
And the "button" "Import table data" is "be.enabled"
And I check replace data
And I import a file "test3.csv"
And I see the message: "SUCCESS"
And the "button" "Validate" is "be.enabled"
And I see the message: "SUCCESS"
And I reload the page
Then I can see the field "Key2" has 0 error

# REP-1439
@sanity @ignore
Scenario: As a custodian/steward, I want to be able to create an external link to a reference dataset inside a reference dataflow.

Given I'm logged at Reportnet page as "userCustodian"
And I can click on "DatasetSchema Test"
And I can click on element "DS-Test2"
Then I can fill a dataset schema with name "Table7", description "description Table7" and with following fields
  | table7f1 | description 1 | Number        |
  | table7f2 | description 2 | External link |
And I can select a "External link" "Table1 - code" with label field "" and linked field "table4f1" and master field "table1f2" and ignore case "" for dataflow "Reference dataflow 2"
And I change to "Tabular data" mode
And I reload the page
And I can add a record
  | 1 | link | 1 |


# REP-461  REP-582 REP-922 REP-1425
@sanity @ignore
Scenario: As a data custodian I can fill a dataset schema with a URL, Phone Number, Attachment, Line, Polygon, DateTime

Given I'm logged at Reportnet page as "userCustodian"
And I can click on "DatasetSchema Test"
And I can click on element "DS-Test2"
Then I can fill a dataset schema with name "Table5", description "description Table5" and with following fields
  | table5f1 | description 1 | Number - Integer |             | true  |
  | table5f2 | description 2 | Number - Decimal |             | false |
  | table5f3 | description 3 | URL              |             | false |
  | table5f4 | description 4 | Email            |             | false |
  | table5f5 | description 5 | Phone            |             | false |
  | table5f6 | description 6 | Attachment       | pdf,txt,csv | false |
  | table5f7 | description 7 | Line             |             | false |
  | table5f8 | description 8 | Polygon          |             | false |
  | table5f9 | description 9 | Datetime         |             | false |

@ignore
# REP-820
Scenario: As a custodian, I want the point as the PoC

Given I'm logged at Reportnet page as "userCustodian"
And I can click on "DatasetSchema Test"
And I can click on element "DS-Test2"
And I can fill a dataset schema with name "Table6", description "description Table6" and with following fields
  | table6f1 | description 1 | Point |  | true |
And I change to "Tabular data" mode
When I can add coordinates to the geometry
  | 35 | 35 |
Then I can update the point cell "35, 35" to EPSG "LAEA-ETRS89 - 3035" and see the new format "6582882.384313043, 1698746.0663871667"

@ignore
# REP-580
@sanity
Scenario: As a data custodian I can manage UNIQUE constraints in tables

Given I'm logged at Reportnet page as "userCustodian"
And I can click on "DatasetSchema Test"
And I can click on element "DS-Test2"
When I can click on "Add unique constraint"
And I can create a unique constraint with table "Table3" and field "table3f2"
Then I can click on "Unique constraints"
And the unique constraint "table3f2" is "be.visible" on the list

@ignore
# REP-990
@sanity
Scenario: As a data custodian I can import a schema

Given I'm logged at Reportnet page as "userCustodian"
And I can click on "DatasetSchema Test"
And I can click on element "New schema"
And I can "import" a dataset schema with name "Dataflow Reportnet Testing"
When I import a file "Dataflow Reportnet Testing.zip"
And I see the message: "SUCCESS"
Then I can click on element "IMPORTED_DS-Test"
And I can see the fields and configurations "<readonly>"
  | Table1 | Field1 | Field 1 description | Number - Integer | required                | readonly |
  | Table1 | Field2 | Field 2 description | Text             |                         | false    |
  | Table2 | Field1 | Field 1 description | Number - Integer | Read only table         | false    |
  | Table2 | Field2 | Field 2 description | Text             | Read only table         | false    |
  | Table3 | Field1 | Field 1 description | Number - Integer | Prefilled               | false    |
  | Table4 | Field1 | Field 1 description | Number - Integer | Fixed number of records | false    |
And the "button" "QC rules" is "be.visible"
And I can filter QCs by "automatic" with "BLOCKER"
And the code rule "testName" is "be.visible" on the list of rules

@ignore
# REP-1185
Scenario: As a Custodian, I want to be able to manage the external integrations for all datasets in all datasets in reporting.

Given I'm logged at Reportnet page as "userCustodian"
And I can click on "Dataset Reportnet Testing"
When I can click on element "DS-Test"
Then the cell with "name" "Field1" is disabled
And the cell with "description" "Field 1 description" is disabled
And the cell with "type" "Number - Integer" is disabled
And publicly available check is "not.be.disabled"
And the "button" "External integrations" is "be.visible"
And the "button" "QC rules" is "be.visible"

@ignore
# REP-696
@sanity
Scenario: As a Custodian, I want to clone all schemas from other dataflow (from my dataflows)
Given I'm logged at Reportnet page as "userCustodian"
And I can click on "DatasetSchema Test"
And I can click on element "New schema"
And I can "clone" a dataset schema with name "Dataset Reportnet Testing"
When I see the message: "SUCCESS"
Then I can click on element "CLONE_DS-Test"

@ignore
# REP-1320
Scenario: As a user I can see the schemas by name in dataflow page

Given I'm logged at Reportnet page as "userCustodian"
And I can click on "DatasetSchema Test"
Then the first dataset is "CLONE_DS-Test" and last is "IMPORTED_DS-Test"

@ignore
#REP-1360
Scenario: As a requester, the characters to create table and fields are limited

Given I'm logged at Reportnet page as "userCustodian"
And I can click on "DatasetSchema Test"
And I can click on element "DS-Test2"
When I can fill a dataset schema with name "Table*/+test", description "description Tabletest" and with following fields
  | tabletest*f1 | description 1 | Number - Integer |  | true |
Then the table "Tabletest" has 0 records

@ignore
#REP-1435
@sanity
Scenario: As a  custodian/steward/editor write I can Import CSV to create/update/replace schemas

Given I'm logged at Reportnet page as "userCustodian"
And I can click on "DatasetSchema Test"
And I can click on element "New schema"
And I can "create" a dataset schema with name "DS-Import"
And I reload the page
And I can click on element "DS-Import"
And I can fill a dataset schema with name "Tabletest", description "description Tabletest" and with following fields
  | tabletestf1 | description 1 | Number - Integer |  | false |
When I can click on "Import definition"
And I import a file "Tabletest.csv"
And I reload the page
Then I can see the fields and configurations "<readonly>"
  | Tabletest | tabletestf1 | description 1 | Number - Integer | false    | false |
  | Tabletest | tabletestf2 | description 2 | Number - Integer | required | false |
  | Tabletest | tabletestf3 | description 3 | Text             | false    | false |

@ignore
#REP-1435
@sanity
Scenario: As a  custodian/steward/editor write I can Export CSV to create/update/replace schemas

Given I'm logged at Reportnet page as "userCustodian"
And I can click on "DatasetSchema Test"
And I can click on element "DS-Import"
When I can click on "Export definition"

@ignore
#REP-1323
Scenario: As a custodian I can delete the dataset data (but prefilled tables)

Given I'm logged at Reportnet page as "userCustodian"
And I can click on "DatasetSchema Test"
And I can click on element "DS-Test2"
When the "button" "Delete dataset data" is "be.enabled"
And I delete dataset data "without prefilled" tables
And I see the message: "SUCCESS"
And I see the message: "SUCCESS"
And I reload the page
And I click on table "Table1"
And I change to "Tabular data" mode
Then the table "Table1" has 3 records
And I click on table "Table2"
And I change to "Tabular data" mode
Then the table "Table2" has 0 records
And I click on table "Table3"
And I change to "Tabular data" mode
Then the table "Table3" has 0 records
And I click on table "Table4"
And I change to "Tabular data" mode
Then the table "Table4" has 0 records
And I click on table "Table5"
And I change to "Tabular data" mode
Then the table "Table5" has 0 records
And I click on table "Table6"
And I change to "Tabular data" mode
Then the table "Table6" has 0 records
And I click on table "Table7"
And I change to "Tabular data" mode
Then the table "Table7" has 0 records

@ignore
#REP-1323
Scenario: As a custodian I can delete the dataset data (with prefilled tables)

Given I'm logged at Reportnet page as "userCustodian"
And I can click on "DatasetSchema Test"
And I can click on element "DS-Test2"
When the "button" "Delete dataset data" is "be.enabled"
And I delete dataset data "with prefilled" tables
And I see the message: "SUCCESS"
And I see the message: "SUCCESS"
And I reload the page
And I click on table "Table1"
And I change to "Tabular data" mode
Then the table "Table1" has 0 records

@ignore
Scenario: As a data custodian I can delete a dataset schema

Given I'm logged at Reportnet page as "userCustodian"
And I can click on "DatasetSchema Test"
And I can "delete" a dataset schema with name "DS-Test2"
Then the "button" "DS-Test2" is "not.exist"

@ignore
Scenario: As a data custodian I can delete a data flow

Given I'm logged at Reportnet page as "userCustodian"
And I can click on "DatasetSchema Test"
And the "action" "Edit" is "be.visible"
Then I can delete the dataflow "DatasetSchema Test"
