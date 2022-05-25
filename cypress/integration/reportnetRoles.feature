Feature: Reportnet Roles - As an existing user on the Repornet system I want to test the actions with Roles

Scenario: As a data custodian I can add a new data flow

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And the "action" "Create new dataflow" is "be.visible"
Then I can "Create" a dataflow with name "New Test Roles" and description "Description New Test Roles" and obligation "(C) Information on the assessment regime (Article 7)" with "noFilters"
And I can click on "New Test Roles"
And I can click on element "New schema"
And I can "create" a dataset schema with name "DS-Test"
And I can click on "DS-Test"


Scenario: As a data custodian I can add a Data provider

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "New Test Roles"
And I can click on element "Manage reporters"
Then I can "add" a Data provider with Representative of "Country" and account "testprovider@reportnet.net" and Data provider "Spain"


Scenario: As a data custodian I can edit a Data provider

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "New Test Roles"
And I can click on element "Manage reporters"
Then I can "edit" a Data provider with Representative of "Country" and account "testcustodian@reportnet.net" and Data provider "France"


Scenario: As a data custodian I can delete a Data provider

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "New Test Roles"
And I can click on element "Manage reporters"
Then I can "delete" a Data provider with Representative of "Country" and account "testprovider@reportnet.net" and Data provider "France"


# REP-708
Scenario: As a CUSTODIAN or STEWARD, I want to share access rights with editors in my dataflow

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "New Test Roles"
And the "action" "Manage editors" is "be.visible"
When I can "add" a new editor "testprovider@reportnet.net" with permissions "Read/Write"
And The user logout
And I'm logged at Reportnet page as user "testprovider" and password "1234"
And I can click on "New Test Roles"
And I can click on element "DS-Test"
Then I can fill a dataset schema with name "Table1", description "description Table1" and with following fields
 | table1f1 | description 1 | Number - Integer | | true  |


# REP-36
@sanity
Scenario: As a LEAD REPORTER, I want to share access rights with reporters for a dataflow

Given I'm logged at Reportnet page as user "testprovider" and password "1234"
And I can click on "Dataflow Reportnet Testing"
And I can click on element "Spain"
And the "action" "Manage reporters" is "be.visible"
When I can "add" a new editor "testleadreporter@reportnet.net" with permissions "Read/Write"
And The user logout
And I'm logged at Reportnet page as user "testleadreporter" and password "1234"
And I can click on "Dataflow Reportnet Testing"
And I can click on element "DS-Test"


Scenario: As a data custodian I can delete a data flow

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "New Test Roles"
And the "action" "Edit" is "be.visible"
Then I can delete the dataflow "New Test Roles"
And I see the message: "SUCCESS"


# REP-382
@sanity
Scenario: As a data custodian I can add more representatives when a DC is already created

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "Dataflow Reportnet Testing"
And I can click on element "Manage reporters"
Then I can "addMore" a Data provider with Representative of "Country" and account "testprovider@reportnet.net" and Data provider "Belgium"
And I reload the page
And I can click on element "Create new datasets"
And I can add datasets for new Representatives
And I see the message: "SUCCESS"
And I can click on element "France"
