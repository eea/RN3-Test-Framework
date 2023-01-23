Feature: Control Status - As an Admin on the Repornet system I want to test delete dataset data 

Scenario: a) As a data custodian I can add a new data flow

Given I'm logged at Reportnet page as "userCustodian"
And the "action" "Create new dataflow" is "be.visible"
And I "Create" a reporting dataflow with name "Dataflow Reportnet Testing" and description "Dataflow description test" and obligation "(C) Information on the assessment regime (Article 7)" with "noFilters"
And I click on "Dataflow Reportnet Testing"
And I can click on element "New schema"
When I can "create" a dataset schema with name "DS-Test"
Then I can click on element "DS-Test"
And I can fill a dataset schema with name "t7", description "description Table1" and with following fields
 | Field1 | Field 1 description | Text             |  true |
 | Field2 | Field 2 description | Text             |       |
And I can go to the dataflow page
And I can click on element "Manage lead reporters"
And I can "add" a Data provider with Representative of "EEA Member countries" and account "test.provider@abc.com" and Data provider "Spain"
And I can go to the dataflow page
And I can click on element "Create data collections"
And I can create data collections with a technical acceptance step for the reporter submissions and "public"
And I see the message: "SUCCESS"

Scenario: As an Admin I am able to delete dataset data from Control status window

Given I'm logged at Reportnet page as "userProvider"
And I filter the dataflow list by "name" with "Dataflow Reportnet Testing"
And I click on "Dataflow Reportnet Testing"
And I can click on element "DS-Test"
When the "button" "Import table data" is "be.enabled"
And I import a file "t7.csv"
And I reload the page
And I can go to the dataflow page
And I can click on element "Release to data collection"
And I can confirm release to data collection with "no restrict to public"
And I see the message SUCCESS RELEASE TO DATA COLLECTION
And I logout
And I'm logged at Reportnet page as "userCustodian"
And I filter the dataflow list by "name" with "Dataflow Reportnet Testing"
And I click on "Dataflow Reportnet Testing"
And I can click on element "Spain"
And I get the provider Id from the url
And I can click on element "DS-Test"
And I get the dataset ID from the url
And I logout
And I'm logged at Reportnet page as "userAdmin"
And the button Control status is visible
And I click on the Control status button
And I click on the datasetId field
And I type the dataset ID in the control status window
And I click on the dataProviderId field
And I type the provider Id
And I click on the Find dataset button
And I click on the delete button
And I logout
And I'm logged at Reportnet page as "userCustodian"
And I filter the dataflow list by "name" with "Dataflow Reportnet Testing"
And I click on "Dataflow Reportnet Testing"
And I can click on element "Spain"
And I can click on element "DS-Test"
And the dataset table "t7" has 0 records
