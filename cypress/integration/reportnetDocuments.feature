Feature: Reportnet Documents - As an existing user on the Repornet system I want to test the actions with documents

@sanity
Scenario: As a data custodian I can add documents to dataflow

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "Dataflow Reportnet Testing"
And I can click on element "Dataflow help"
Then the "button" "Upload" is "be.enabled"
When I "upload" the document "test.csv" with description "description" and language "English"
Then I see the message: "INFO"
Then I see the message: "SUCCESS"
And the table "Supporting documents" has 1 records


Scenario: As a data custodian I can edit documents to dataflow

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "Dataflow Reportnet Testing"
And I can click on element "Dataflow help"
When I "edit" the row 1
And I "edit" the document "test.csv" with description "description edited" and language "Spanish"
Then I see the message: "INFO"
And I see the message: "SUCCESS"
And the table "Supporting documents" has 1 records


@sanity
Scenario Outline: As a Reportnet User I can download documents

Given I'm logged at Reportnet page as user "<user>" and password "<password>"
And I can click on "Dataflow Reportnet Testing"
And I can click on element "Dataflow help"
Then I can download the document

   Examples: 
    | user          | password |
    # | testprovider  | 1234     |
    | testcustodian | 1234     |


Scenario: As a data custodian I can delete documents to dataflow

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "Dataflow Reportnet Testing"
And I can click on element "Dataflow help"
When I "delete" the row 1
And I reload the page
Then the table "Supporting documents" has 0 records
