Feature: Reportnet Documents - As an existing user on the Repornet system I want to test the actions with documents


@sanity
Scenario: As a data custodian I can add a new data flow with obligations

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And the "action" "Create new dataflow" is "be.visible"
Then I can "Create" a dataflow with name "Document Reportnet Testing" and description "Dataflow document test" and obligation "Agenda 21 National Report" with "filters"
| | | | | Agenda |
And I can click on "Document Reportnet Testing"
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
Then I can "add" a Data provider with Representative of "EEA Member countries" and account "testprovider@reportnet.net" and Data provider "Spain"
And I can click on element "Manage lead reporters"
And I can see the representative "Spain" "testprovider@reportnet.net"


# REP-1229
@sanity
Scenario: As a data custodian I can add documents to dataflow

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "Document Reportnet Testing"
And I can click on element "Dataflow help"
And the "button" "Upload" is "be.enabled"
When I "upload" the document "test.csv" with description "test description" and language "English" marked as "private"
And I see the message: "INFO"
And I see the message: "SUCCESS"
Then the table "Supporting documents" has 1 records
And I reload the page
And the "button" "Upload" is "be.enabled"
And I "upload" the document "Table1.csv" with description "table description" and language "English" marked as "private"
And I see the message: "INFO"
And I see the message: "SUCCESS"
Then the table "Supporting documents" has 2 records
And The first record is "table description" and the last record is "test description"


# REP-1416
Scenario: As a data custodian I can not upload documents with empty fields

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "Document Reportnet Testing"
And I can click on element "Dataflow help"
And the "button" "Upload" is "be.enabled"
When I "upload" the document "Table1.csv" with description " " and language "English" marked as "private"
And I see the "descriptionDocumentFileUpload" input with error


Scenario: As a data custodian I can edit documents to dataflow

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "Document Reportnet Testing"
And I can click on element "Dataflow help"
When I "edit" the row 1
And I "edit" the document "Table1.csv" with description "description edited" and language "Spanish" marked as "private"
Then I see the message: "INFO"
And I see the message: "SUCCESS"
And the table "Supporting documents" has 2 records


@sanity
Scenario Outline: As a Reportnet User I can download documents

Given I'm logged at Reportnet page as user "<user>" and password "<password>"
And I can click on "Document Reportnet Testing"
And I can click on element "Dataflow help"
Then I can download the document

Examples:
    | user          | password |
    | testcustodian | 1234     |


Scenario: As a data custodian I can delete documents to dataflow

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "Document Reportnet Testing"
And I can click on element "Dataflow help"
When I "delete" the row 1
And I reload the page
Then the table "Supporting documents" has 1 records


#REP-1685
Scenario: As a custodian/steward, I want to be able to set the documents as public

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "Document Reportnet Testing"
And I can click on element "Dataflow help"
And the "button" "Upload" is "be.enabled"
When I "upload" the document "test.csv" with description "public document" and language "English" marked as "public"


@sanity
Scenario: As a data custodian I can create data collections

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "Document Reportnet Testing"
And I can click on element "Create data collections"
Then I can create data collections with a technical acceptance step for the reporter submissions and "public"
And I see the message: "SUCCESS"


#REP-1685
Scenario: As a custodian/steward I can see all the public documents in the dataflow public page as extra information if the dataflow is public

Given I'm in Reportnet page
And I can click on "View by obligation dataflow"
And I "can" see the publicly dataflow "Document Reportnet Testing"
And I can see for dataflow "Document Reportnet Testing" the instrument "Agenda 21 National Report", status "Open"
When I can click on "Document Reportnet Testing"
Then the public table "Documents" has 1 records
And I login as user "testcustodian" and password "1234"
