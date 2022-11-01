Feature: Reportnet Dataflow - As an existing user on the Repornet system I want to test the actions with dataflow data


@sanity
Scenario: As a data custodian I can add a new data flow

Given I'm logged at Reportnet page as "userCustodian"
And the "action" "Create new dataflow" is "be.visible"
Then I "Create" a reporting dataflow with name "New Test" and description "new description New Test" and obligation "(C) Information on the assessment regime (Article 7)" with "noFilters"
And I click on "New Test"
And I can click on element "New schema"
And I can "create" a dataset schema with name "DS-Test"
And I can click on element "DS-Test"
Then I can fill a dataset schema with name "Table1", description "description Table1" and with following fields
 | Field1 | Field 1 description | Number - Integer | | true |

@sanity
Scenario: As a data custodian I can edit a data flow

Given I'm logged at Reportnet page as 'userCustodian'
And I click on "New Test"
And the "action" "Edit" is "be.visible"
Then I "Save" a dataflow with name "Test edited" and description "old description Test2" and obligation "(C) Preliminary information on the assessment regime (Article 7)" with "noFilters"


#REP-1994
@ignore
Scenario Outline: As a Reportnet User I can filter the dataflow list

Given I'm logged at Reportnet page as 'userCustodian'
And the dataflow list has 2 items
Then I can filter by "<type>" with "<filter>"
And the dataflow list has <total> items

  Examples:
    | type        | filter    | total |
    | name        | reportnet | 1     |
    | description | dataflow  | 1     |
    | Status      | DESIGN    | 1     |
    | Role        | CUSTODIAN | 2     |


#REP-1994
@ignore
Scenario Outline: As a Reportnet User I can clear filters in the dataflow list

Given I'm logged at Reportnet page as 'userCustodian'
And the dataflow list has 2 items
When I can filter by "<type>" with "<filter>"
And the dataflow list has <total> items
Then I can clear dataflow filters
And the dataflow list has 2 items

  Examples:
    | type        | filter    | total |
    | name        | reportnet | 1     |
    | name        | reportnet | 1     |
    | description | dataflow  | 1     |


# REP-1141
@ignore
Scenario Outline: As a user, I want to be able to pin some dataflows in the dataflow list.

Given I'm logged at Reportnet page as 'userCustodian'
Then I can pin the dataflow "<Test edited>"
And I see the message: "message"

  Examples:
    | pin   | dataflow    | message                        |
    | pin   | Test edited | You have pinned the dataflow   |
    | unpin | Test edited | You have unpinned the dataflow |

# REP-1141
Scenario: As a user, I want to be able to pin some dataflows in the dataflow list.

Given I'm logged at Reportnet page as 'userCustodian'
Then I can pin the dataflow "Test edited"
And I see the message for pinned dataflows "Test edited"

  


@ignore
Scenario: As a user, I want to be able to unpin some dataflows in the dataflow list.

Given I'm logged at Reportnet page as 'userCustodian'
Then I can "unpin" the dataflow "Test edited"
And I see the message: "message"
 


#REP-1994
@ignore
Scenario Outline: As a Reportnet User I can sort the dataflow list

Given I'm logged at Reportnet page as 'userCustodian'
And I sort the dataflow list by "<field>"
Then The first dataflow is "<first>" and the last dataflow is "<last>"

  Examples:
    | field              | first       | last                       |
    | Name               | Test edited | Dataflow Reportnet Testing |
    | Description        | Test edited | Dataflow Reportnet Testing |
    | Status             | Test edited | Dataflow Reportnet Testing |
    | Legal Instrument   | Test edited | Dataflow Reportnet Testing |

#REP-1496
@sanity
Scenario: As a registered user I can import a zip file through an external integration

Given I'm logged at Reportnet page as 'userCustodian'
And I click on "Test edited"
And I can click on element "DS-Test"
And the "button" "External integrations" is "be.visible"
And the "button" "Create external integration" is "be.visible"
Then I can "Create" the new external integration "import"
  | ZIP | ZIP | ReportNetTesting | ImportZIP_test.fmw | IMPORT | zip | p1 | 1 |
And the "button" "Close" is "be.visible"
And I click on the tab "Import dataset data"
Then I can see the list of external "imports" with the name "ZIP (.zip)"
And I can click on the list element with the name "ZIP (.zip)"
And I import a "zip" file "DS-Test.zip"
Then I see the message: "SUCCESS"
And the "action" "Notifications" is "be.visible"
Then I see the notification "Loaded data completed at DS-Test" in the notification received list


@sanity
Scenario: As a data custodian I can delete a data flow

Given I'm logged at Reportnet page as 'userCustodian'
And I click on "Test edited"
And the "action" "Edit" is "be.visible"
Then I can delete the dataflow "Test edited"
And I see the message: "SUCCESS"

#REP-1438 REP-1605
@sanity
Scenario: As a custodian/steward, I want to be able to create a Reference dataflow.

Given I'm logged at Reportnet page as 'userCustodian'
And I can click on "Reference dataflows"
And the "action" "Create new dataflow" is "be.visible"
Then I "Create" a reference dataflow with name "Reference dataflow1" and description "new description Reference Test"
And I click on "Reference dataflow1"
And I can click on element "New schema"
And I can "create" a dataset schema with name "DS-Reference-Test"
And I can click on element "DS-Reference-Test"
Then I can fill a dataset schema with name "Table1", description "description Table1" and with following fields
  | code  | code description  | Number - Integer |  | true  |
  | label | label description | Text             |  | false |
Then I can fill a dataset schema with name "Table2", description "description Table2" and with following fields
  | code  | code description  | Number - Integer |  | false |
  | label | label description | Text             |  | false |
And I click on table "Table1"
And I change to "Tabular data" mode
And I can add a record
  | 1 | test1 |
And I can add a record
  | 2 | test2 |
And I can add a record
  | 3 | test3 |
And I can go to the dataflow page
And I can create reference datasets
And I can see a warning for the tables without PK
And I see the message: "SUCCESS"


Scenario: As a custodian I want to be able to filter reference dataflows

Given I'm logged at Reportnet page as 'userCustodian'
And I can go to the list dataflows page
And I can click on "Reference dataflows"
And I can filter by "name" with "Reference dataflow1"
And I can click on "Reference dataflow1"
And the "action" "Referencing dataflows" is "be.visible"

#REP-1438
Scenario: As a custodian/steward, I want to be able to update data in a reference dataset if it is marked as updatable.

Given I'm logged at Reportnet page as 'userCustodian'
And I can click on "Reference dataflows"
And I can filter by "name" with "Reference dataflow1"
And I click on "Reference dataflow1"
And I can click on element "DS-Reference-Test"
And I "can not" update the cell with the text "test1" to the text "test4" in a "reference dataset"
And the "action" "Update status" is "be.visible"
When I "Unlock" the reference dataset
And I "can" update the cell with the text "test1" to the text "test4" in a "reference dataset"
And the "action" "Update status" is "be.visible"
Then I "Lock" the reference dataset
And I "can not" update the cell with the text "test2" to the text "test4" in a "reference dataset"

#REP-1689
@sanity
Scenario: As a custodian, I want to be able to create a Citizen and science dataflow.

Given I'm logged at Reportnet page as 'userCustodian'
And I can click on tab "Citizen science dataflows"
And the "action" "Create new dataflow" is "be.visible"
Then I "Create" a dataflow with name "Citizen test dataflow" and description "new description Citizen Test" and obligation "(C) Information on the assessment regime (Article 7)" with "noFilters"


#REP-1647

Scenario: As an admin, I want to be able to see all dataflows.

Given I'm logged at Reportnet page as 'userAdmin'
Then I can click on "Dataflow Reportnet Testing"
And I can click on element "Dataflow help"
And I can go to the list dataflows page
Then I can click on "Dataflow Reportnet Testing"
And the "action" "Manage requesters" is "be.visible"
And I can go to the list dataflows page
And I can click on tab "Business dataflows"
Then I can click on "Business dataflow1"
And I can go to the list dataflows page
And I can click on "Reference dataflows"
Then I can click on "Reference dataflow1"
And I can go to the list dataflows page
And I can click on "Citizen science dataflows"
Then I can click on "Citizen test"




