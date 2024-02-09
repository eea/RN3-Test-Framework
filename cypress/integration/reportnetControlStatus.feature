Feature: Control Status - As an Admin on the Repornet system I want to test delete dataset data 

Scenario: a) As a data custodian I can add a new data flow

Given I'm logged at Reportnet3 page as "userCustodian2"
And the "action" "Create new dataflow" is "be.visible"
And I "Create" a reporting dataflow with name "Dataflow Reportnet Testing" and description "Dataflow description test" and obligation "(C) Information on the assessment regime (Article 7)" with "noFilters"
And I click on "Dataflow Reportnet Testing"
And I can click on element "New schema"
And I can create a dataset schema public available with name "DS-Test"
And Confirm new dataset schema creation is visible
Then I can click on element "DS-Test"
And I can fill a dataset schema with name "t7", description "description Table1" and with following fields
 | Field1 | Field 1 description | Text             |  true |
#  | Field2 | Field 2 description | Text             |       |
And I can go to the dataflow page
And I can click on element "Manage lead reporters"
And I can "add" a Data provider with Representative of "All countries: EEA member countries PLUS other countries and territories" and account "test.provider@abc.com" and Data provider "Spain"
And I can go to the dataflow page
And I can click on element "Create data collections"
And I can create data collections with a technical acceptance step for the reporter submissions and "public"
And I wait for notification
And I wait for notification
And I see the message: "SUCCESS"


Scenario: b) As a provider I can release to data collection

Given I'm logged at Reportnet3 page as "userProvider"
And I filter the dataflow list by "name" with "Dataflow Reportnet Testing"
And I click on "Dataflow Reportnet Testing"
And I can click on element "DS-Test"
When the "button" "Import table data" is "be.enabled"
And I import a file "t7.csv"
And I can go to the dataflow page
And I wait for enter
And I can click on element "Release to data collection"
And I can confirm release to data collection with "no restrict to public"
And I wait for notification
And I wait for notification
And I see the message: "SUCCESS"


Scenario: c) As an Admin I am able to delete dataset data from Control status window

And I'm logged at Reportnet3 page as "userCustodian2"
And I wait for enter
And I filter the dataflow list by "name" with "Dataflow Reportnet Testing"
And I click on "Dataflow Reportnet Testing"
And I can click on element "Spain"
And I get the provider Id from the url
And I can click on element "DS-Test"
And I get the dataset ID from the url
And I logout
And I'm logged at Reportnet page as "userAdmin"
And I wait for enter
And the button Control status is visible
And I click on the Control status button
And I click on the datasetId field
And I type the dataset ID in the control status window
And I click on the dataProviderId field
And I type the provider Id
And I click on the Find dataset button
And I click on the delete button
And I wait for enter
And I logout
And I'm logged at Reportnet page as "userCustodian2"
And I filter the dataflow list by "name" with "Dataflow Reportnet Testing"
And I wait for enter
And I click on "Dataflow Reportnet Testing"
And I can click on element "Spain"
And I can click on element "DS-Test"
And I wait for enter
And the dataset table "t7" has 0 records
