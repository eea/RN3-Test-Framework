Feature: Reportnet Dataset Schemas - As an existing user on the Repornet system I want to test the Dataset Schemas page


Scenario: a) As a data custodian I can create new dataflow and dataset schema

Given I'm logged at Reportnet page as "userCustodian2"
And the "action" "Create new dataflow" is "be.visible"
And I "Create" a reporting dataflow with name "DatasetSchema Test" and description "Description New Test" and obligation "(C) Information on the assessment regime (Article 7)" with "noFilters"
And I click on "DatasetSchema Test"
Then I can click on element "New schema"
And I can create a dataset schema public available with name "DS-Test"
And Confirm new dataset schema creation is visible
And I can click on "DS-Test"

Scenario: b) As a data custodian I can rename a dataset schema

Given I'm logged at Reportnet page as "userCustodian2"
And I click on "DatasetSchema Test"
And I can "rename" a dataset schema with name "DS-Test2"
Then I can click on "DS-Test2"

Scenario: c) No dashboard when there is no data

Given I'm logged at Reportnet page as "userCustodian2"
And I click on "DatasetSchema Test"
And I can click on element "DS-Test2"
Then the "button" "Dashboards" is "be.disabled"


Scenario: d) As a data custodian I can fill a dataset schema

Given I'm logged at Reportnet page as "userCustodian2"
And I click on "DatasetSchema Test"
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
Scenario: e) As a user I can filter data

Given I'm logged at Reportnet page as "userCustodian2"
And I click on "DatasetSchema Test"
And I can click on element "DS-Test2"
And I change to "Tabular data" mode
And the dataset table "Table1" has 3 records
When I filter by value "3"
Then the dataset table "Table1" has 1 records

# REP-1334
Scenario: f) As a data custodian I can fill a dataset schema with a single select

Given I'm logged at Reportnet page as "userCustodian2"
And I click on "DatasetSchema Test"
And I can click on element "DS-Test2"
Then I can fill a dataset schema with name "Table2", description "description Table2" and with following fields
  | table2f1 | description 1 | Single select    | Yes{enter}No{enter}N/A |      |
  | table2f2 | description 2 | Number - Integer |                        | true |
  | table2f3 | description 3 | Multiple select  | A{enter}B{enter}C      |      |



Scenario: g) As a data custodian I can check a field as a pk

Given I'm logged at Reportnet page as "userCustodian2"
And I click on "DatasetSchema Test"
And I can click on element "DS-Test2"
Then I can fill a dataset schema with name "Table3", description "description Table3" and with following fields
  | table3f1 | description 1 | Number - Integer |                        | true  |
  | table3f2 | description 2 | Single select    | Yes{enter}No{enter}N/A | false |


# REP-924
Scenario: h) As a data custodian I can fill a dataset schema with a link configuring the label of the linked fields and the conditional fields

Given I'm logged at Reportnet page as "userCustodian2"
And I click on "DatasetSchema Test"
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
Scenario: i) As a data custodian I can ignore case in links tables while filling a dataset schema

Given I'm logged at Reportnet page as "userCustodian2"
And I click on "DatasetSchema Test"
And I can click on element "DS-Test2"
And I can fill a dataset schema with name "Table10", description "description Table10" and with following fields
| table10f1 | description 1 | Text |  | true  |
| table10f2 | description 2 | Text |  | false |
And I change to "Tabular data" mode
And I can add a record
  | Key1 | Test1 |
And I can add a record
  | Key2 | Test2 |
And I can fill a dataset schema with name "Table11", description "description Table11" and with following fields
| table11f1 | description 1 | Text |  | true  |
| table11f2 | description 2 | Link |  | false |
And I can select a "Link" "Table10 - table10f1" with label field "table10f2" and linked field "" and master field "" and ignore case "" for dataflow ""
And I change to "Tabular data" mode
And the "button" "Import table data" is "be.enabled"
And I import a file "test3.csv"
And I see the message: "SUCCESS"
And the "button" "Validate" is "be.enabled"
And I wait for notification
And I wait for notification
And I see the message: "SUCCESS"
And I reload the page
And I can see the field "Key2" has 2 error
And the "button" "Show validations" is "be.visible"
And the code rule "TC30" with message "The value is not a valid member of the referenced list." is visible on the list of validations
And I can click on the button with text "Close"
And I change to "Design" mode
And I can click on the button with text "Table10 - table10f1"
And I can check on the checkbox ignore case
And I can click on the button with text "Save"
And I change to "Tabular data" mode
And the "button" "Import table data" is "be.enabled"
And I check replace data
And I import a "csv" file "test4.csv"
And I see the message: "SUCCESS"
And the "button" "Validate" is "be.enabled"
And I wait for notification
And I wait for notification
And I see the message: "SUCCESS"
And I reload the page
Then I can see the field "Key2" has 0 error

# REP-1439
Scenario: j) As a custodian/steward, I want to be able to create an external link to a reference dataset inside a reference dataflow.

Given I'm logged at Reportnet page as "userCustodian2"
When I filter the dataflow list by "name" with "DatasetSchema Test"
And I click on "DatasetSchema Test"
And I can click on element "DS-Test2"
And I wait for enter
Then I can fill a dataset schema with name "Table7", description "description Table7" and with following fields
  | table7f1 | description 1 | Number        |
  | table7f2 | description 2 | External link |
And I can select a "External link" "Table1 - code" with label field "" and linked field "table4f1" and master field "table1f2" and ignore case "" for dataflow "Reference dataflow 2"
And I change to "Tabular data" mode
And I reload the page
And I can add a record
  | 1 | link | 1 |


# REP-461  REP-582 REP-922 REP-1425
Scenario: k) As a data custodian I can fill a dataset schema with a URL, Phone Number, Attachment, Line, Polygon, DateTime

Given I'm logged at Reportnet page as "userCustodian2"
And I click on "DatasetSchema Test"
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

# REP-820
Scenario: l) As a custodian, I want the point as the PoC

Given I'm logged at Reportnet page as "userCustodian2"
And I click on "DatasetSchema Test"
And I can click on element "DS-Test2"
And I can fill a dataset schema with name "Table6", description "description Table6" and with following fields
  | table6f1 | description 1 | Point |  | true |
And I change to "Tabular data" mode
When I can add coordinates to the geometry
  | 35 | 35 |
Then I can update the point cell "35, 35" to EPSG "LAEA-ETRS89 - 3035" and see the new format "6582882.384313043, 1698746.0663871667"


# REP-580
Scenario: n) As a data custodian I can manage UNIQUE constraints in tables

Given I'm logged at Reportnet page as "userCustodian2"
And I click on "DatasetSchema Test"
And I can click on element "DS-Test2"
When I can click on "Add unique constraint"
And I can create a unique constraint with table "Table3" and field "table3f2"
Then I can click on "Unique constraints"
And the unique constraint "table3f2" is "be.visible" on the list

# REP-990
Scenario: o) As a data custodian I can import a schema

Given I'm logged at Reportnet page as "userCustodian2"
And I click on "DatasetSchema Test"
And I can click on element "New schema"
And I can "import" a dataset schema with name "Dataflow Reportnet Testing"
When I import a dataset schema "zip" file "Dataflow Reportnet Testing.zip"
And I wait for notification
And I wait for notification
And I wait for notification
And I reload the page
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


#REP-1360
Scenario: r) As a requester, the characters to create table and fields are limited

Given I'm logged at Reportnet page as "userCustodian2"
And I click on "DatasetSchema Test"
And I can click on element "DS-Test2"
When I can fill a dataset schema with name "Table*/+test", description "description Tabletest" and with following fields
  | tabletest*f1 | description 1 | Number - Integer |  | true |
Then the table "Tabletest" has 0 records


#REP-1435
Scenario: s) As a  custodian/steward/editor write I can Import CSV to create/update/replace schemas

Given I'm logged at Reportnet page as "userCustodian2"
And I click on "DatasetSchema Test"
And I can click on element "New schema"
And I can create a dataset schema public available with name "DS-Import"
And Confirm new dataset schema creation is visible
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

#REP-1435
Scenario: t) As a  custodian/steward/editor write I can Export CSV to create/update/replace schemas

Given I'm logged at Reportnet page as "userCustodian2"
And I click on "DatasetSchema Test"
And I can click on element "DS-Import"
And I wait for enter
When I can click on "Export definition"


#REP-1323
Scenario: v) As a custodian I can delete the dataset data (with prefilled tables)

Given I'm logged at Reportnet page as "userCustodian2"
And I click on "DatasetSchema Test"
And I can click on element "DS-Test2"
When the "button" "Delete dataset data" is "be.enabled"
And I delete dataset data "with prefilled" tables
And I see the message: "SUCCESS"
And I see the message: "SUCCESS"
And I reload the page
And I click on table "Table1"
And I change to "Tabular data" mode
Then the table "Table1" has 0 records


Scenario: x) As a data custodian I can delete a dataset schema

Given I'm logged at Reportnet page as "userCustodian2"
And I click on "DatasetSchema Test"
And I can "delete" a dataset schema with name "DS-Test2"
Then the "button" "DS-Test2" is "not.exist"


Scenario: y) As a data custodian I can delete a data flow

Given I'm logged at Reportnet page as "userCustodian2"
And I wait for enter
And I click on "DatasetSchema Test"
And the "action" "Edit" is "be.visible"
Then I can delete the dataflow "DatasetSchema Test"