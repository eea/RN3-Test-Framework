Feature: Background main application testing


Scenario Outline: As a Reportnet User I can add dataflow
Given I'm logged at Reportnet page as user "<user>" and password "<password>"
Then the "action" "Create new dataflow" is "<visible>"

  Examples: 
    | user          | password | visible     | 
    | testprovider  | 1234     | not.visible | 
    | testcustodian | 1234     | be.visible  | 


@sanity
Scenario: As a data custodian I can add a new data flow with obligations

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And the "action" "Create new dataflow" is "be.visible"
Then I can "Create" a dataflow with name "Dataflow Reportnet Testing" and description "Dataflow description test" and obligation "Agenda 21 National Report" with "filters"
| | | | | Agenda |
And validate the dataflow "Dataflow Reportnet Testing"


@sanity
Scenario: As a data custodian I can create new dataset schema

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "Dataflow Reportnet Testing"
And I can click on element "New schema"
And I can "create" a dataset schema with name "DS-Test"
Then I can click on "DS-Test"


# REP-816
Scenario: As a data custodian I can see the integration to FME is already created

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "Dataflow Reportnet Testing"
And I can click on element "DS-Test"
And I can click on the tab "External integrations"
And The integration "Export EU Dataset" is "be.visible" on the list of external integrations


@sanity
Scenario: As a data custodian I can fill a dataset schema

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "Dataflow Reportnet Testing"
And I can click on element "DS-Test"
Then I can fill a dataset schema with name "Table1", description "description Table1" and with following fields
 | Field 1 | Field 1 description | Number - Integer | | |
 | Field 2 | Field 2 description | Text             | | |


#REP-457
Scenario: As a data custodian I can fill a read only (and prefill) dataset schema 

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "Dataflow Reportnet Testing"
And I can click on element "DS-Test"
And I can fill a dataset schema with name "Table2", description "description Table2" and with following fields
 | Field 1 | Field 1 description | Number - Integer | | |
And I change to "view" mode
And I can add a record 
|1| |
And I can add a record 
|2| |
Then I mark the table as a "read only"


#REP-458
Scenario: As a data custodian I can fill a prefilled dataset schema 

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "Dataflow Reportnet Testing"
And I can click on element "DS-Test"
And I can fill a dataset schema with name "Table3", description "description Table3" and with following fields
 | Field 1 | Field 1 description | Number - Integer | | |
And I change to "view" mode
And I can add a record 
|3| |
And I can add a record 
|4| |
Then I mark the table as a "prefilled"


@sanity
Scenario: As a data custodian I can add a Data provider

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "Dataflow Reportnet Testing"
And I can click on element "Manage reporters"
Then I can "add" a Data provider with Representative of "Country" and account "testprovider@reportnet.net" and Data provider "Spain"
And I can click on element "Manage reporters"
And I can "addMore" a Data provider with Representative of "Country" and account "testprovider@reportnet.net" and Data provider "France"


@sanity
Scenario: As a data custodian I can create data collections

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "Dataflow Reportnet Testing"
And I can click on element "Create data collections"
Then I can create data collections
And I see the message: "SUCCESS"

# REP-816
Scenario: As a data custodian I can see the EU dataset is already created for each Data collection

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "Dataflow Reportnet Testing"
And I can click on element "EU Dataset - DS-Test"


# REP-816
Scenario: As a data custodian I can export EU Datasets

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "Dataflow Reportnet Testing"
And I can click on element "Export EU Datasets"


#REP-457
Scenario: As a data provider I can not modify a read only table
Given I'm logged at Reportnet page as user "testprovider" and password "1234"
And I can click on "Dataflow Reportnet Testing"
And I can click on element "Spain"
And I can click on element "DS-Test"
Then I click on table "Table2"
And the "button" "Import table data" is "not.visible"


#REP-458
Scenario: As a data provider I can see the prefilled table
Given I'm logged at Reportnet page as user "testprovider" and password "1234"
And I can click on "Dataflow Reportnet Testing"
And I can click on element "Spain"
And I can click on element "DS-Test"
Then the dataset table "Table3" has 2 records
