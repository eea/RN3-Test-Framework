Feature: Business Dataflow - As an existing user on the Repornet system I want to test the actions with business dataflow data

Scenario: a) As an admin, I want to be able to create a Business dataflow.

Given I'm logged at Reportnet page as 'userAdmin'
And I can click on tab "Business dataflows"
And the "action" "Create new dataflow" is "be.visible"
Then I create a business dataflow with name "Business dataflow1" and description "new description Business Test" and obligation "(C) Information on the assessment regime (Article 7)" and company "Company Group 1" with fmeUser "Reportnet3"
Then I click on "Business dataflow1"
And the "action" "Manage requesters" is "be.visible"
And I can "Add" a editor "test.custodian@abc.com" with permissions "CUSTODIAN"


Scenario: b) As a custodian/steward, I want to be able to set a BDR dataflow as public or not but only for dataflow help

Given I'm logged at Reportnet page as 'userCustodian'
And I can click on tab "Business dataflows"
Then I click on "Business dataflow1"
And I can click on element "Dataflow help"
And the "button" "Upload" is "be.enabled"
When I "upload" the document "test.csv" with description "public document" and language "English" marked as "public"
And I can go to the dataflow page
And I can click on element "New schema"
And I can create a dataset schema public available with name "DS-Business-Test"
And Confirm new dataset schema creation is visible
And I can click on element "DS-Business-Test"
Then I can fill a dataset schema with name "Table1", description "description Table1" and with following fields
  | code  | code description  | Number - Integer |  | true  |
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
And I can click on element "Manage lead reporters"
Then I can "add" a Data provider in a BDR with account "test.provider@abc.com" and Data provider "Company1"
And I can click on element "Create data collections"
Then I can create data collections with a technical acceptance step for the reporter submissions and "public"
And I see the message: "SUCCESS"


Scenario Outline: c) As a provider, I should not be able to manage requesters in a Business dataflow

Given I'm logged at Reportnet page as 'userProvider'
And I can click on tab "Business dataflows"
Then I click on "Business dataflow1"
And the "action" "Manage requesters" is "<visible>"

  Examples:
    | visible|
    | not.exist|


Scenario:  d) As a public user I can see the list of all dataflows marked as publicly available

Given I'm in Reportnet page
And I can click on "View by obligation dataflow"
Then I "can" see the publicly dataflow "Business dataflow1"
When I click on "Business dataflow1"
Then the public table "Documents" has 1 records
And I'm logged at Reportnet page as "userCustodian"


Scenario: e) As a Custodian I want to be able to assign a Lead Reporter whose email doesn't exist to a Dataflow

Given I'm logged at Reportnet page as 'userCustodian'
And I can click on tab "Business dataflows"
Then I click on "Business dataflow1"
And I can click on element "Manage lead reporters"
Then I can "addMore" a Data provider in a BDR with account "temporaryLead@reportnet.net" and Data provider "Company2"
And I can click on element "Manage lead reporters"
Then I can see a tag next to the invalid lead reporter email


Scenario: f) As an admin, I want to be able to select countries in a Business dataflow.

Given I'm logged at Reportnet page as 'userAdmin'
And I can click on tab "Business dataflows"
And the "action" "Create new dataflow" is "be.visible"
Then I create a business dataflow with name "Business dataflow test countries" and description " Business dataflow test countries" and obligation "(C) Information on the assessment regime (Article 7)" and company "Countries" with fmeUser "Reportnet3"
Then I can click on "Business dataflow test countries"
And the "action" "Manage requesters" is "be.visible"
And I can "Add" a editor "test.custodian@abc.com" with permissions "CUSTODIAN"
And I click on close button 
And I logout
And I'm logged at Reportnet page as 'userCustodian'
And I can click on tab "Business dataflows"
And I click on "Business dataflow test countries"
Then I can click on element "Manage lead reporters"
And representative should contain Countries
And representing field should include all "countries.json"


Scenario: g) As a lead reporter I want to be able to see the label for ongoing imports

Given I'm logged at Reportnet page as 'userCustodian2'
And the "action" "Create new dataflow" is "be.visible"
Then I "Create" a reporting dataflow with name "Test import message" and description "test import message" and obligation "(C) Information on the assessment regime (Article 7)" with "noFilters"
And I click on "Test import message"
And the "action" "Manage requesters" is "be.visible"
And I can "Add" a editor "test.provider@abc.com" with permissions "CUSTODIAN"
And I click on close button
And I logout
And I'm logged at Reportnet page as 'userProvider'
And I click on "Test import message"
And I can click on element "New schema"
And I can create a dataset schema public available with name "test import status"
And Confirm new dataset schema creation is visible
And I can click on element "test import status"
And I can fill a dataset schema with name "Test7", description "Test7" and with following fields
| Test7 | testt | Text | | true  |
Then I click on the import dataset data button
And I import a "zip" file "Test7.zip"
And Import is locked is visible
