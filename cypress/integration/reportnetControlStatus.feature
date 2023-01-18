Feature: Control Status window - As an Admin in the Reportnet System I want to test delete dataset data through Control status window

Scenario: As a Custodian I can create Data Collections

Given I'm logged at Reportnet page as "userCustodian"
And the "action" "Create new dataflow" is "be.visible"
And I "Create" a reporting dataflow with name "Dataflow Reportnet Testing" and description "Dataflow description test" and obligation "(C) Information on the assessment regime (Article 7)" with "noFilters"
And I click on "Dataflow Reportnet Testing"
And I can click on element "New schema"
When I can "create" a dataset schema with name "DS-Test"
Then I can click on element "DS-Test"
And I can fill a dataset schema with name "t7", description "description Table1" and with following fields
 | Field1 | Field 1 description | Text             | | true |
 | Field2 | Field 2 description | Text             | |      |
And I can go to the list dataflows page
And I click on "Dataflow Reportnet Testing"
And I can click on element "Manage lead reporters"
And I can "add" a Data provider with Representative of "EEA Member countries" and account "test.provider@abc.com" and Data provider "Spain"
And I can go to the list dataflows page
And I click on "Dataflow Reportnet Testing"
And I can click on element "Create data collections"
And I can create data collections with a technical acceptance step for the reporter submissions and "public"
And I see the message: "SUCCESS"


Scenario: As a provider I can release to Data Collection

Given I'm logged at Reportnet page as "userProvider"
And I filter the dataflow list by "name" with "Dataflow Reportnet Testing"
And I click on "Dataflow Reportnet Testing"
And I can click on element "DS-Test"
When the "button" "Import table data" is "be.enabled"
And I import a file "t7.csv"
And I reload the page
And I can go to the list dataflows page
Then I click on "Dataflow Reportnet Testing"
And I can click on element "Release to data collection"
And I can confirm release to data collection with "no restrict to public"
And I see the message: "SUCCESS"
And I logout
And I'm logged at Reportnet page as "userCustodian"
And I filter the dataflow list by "name" with "Dataflow Reportnet Testing"
And I click on "Dataflow Reportnet Testing"
And I can click on element "Spain"
And I get the provider Id from the url
And I can click on element "DS-Test"
And I get the dataset ID from the url







