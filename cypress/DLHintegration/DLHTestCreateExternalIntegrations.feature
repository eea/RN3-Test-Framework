Feature: External Integrations - As an existing user on the Repornet system I want to test the actions with external integrations

Scenario: a) As a data custodian I can add a new data flow with obligations

Given I'm logged at Reportnet page as 'userCustodian'
And the "action" "Create new dataflow" is "be.visible"
Then I "Create" a reporting dataflow with name "Dataflow Reportnet Testing" and description "Dataflow description test" and obligation "(C) Information on the assessment regime (Article 7)" with "noFilters"
And I click on "Dataflow Reportnet Testing"
And the "action" "Manage requesters" is "be.visible"
And I can "Add" a editor "test.provider@abc.com" with permissions "CUSTODIAN"
And I can "Add" a editor "national.spain@reportnet.net" with permissions "CUSTODIAN"
And I click on close button
And I can click on element "New schema"
And I can create a dataset schema public available with name "DS-Test"
And Confirm new dataset schema creation is visible
Then I can click on element "DS-Test"
Then I can fill a dataset schema with name "Table1", description "description Table1" and with following fields
 | Field1 | Field 1 description | Number - Integer | | true |
 | Field2 | Field 2 description | Text             | |      |

 # REP-816
Scenario: b) As a data custodian I can see the integration to FME is already created

Given I'm logged at Reportnet page as 'userCustodian'
And I click on "Dataflow Reportnet Testing"
And I can click on element "DS-Test"
And I click on the tab "External integrations"
And The integration "Export EU Dataset" is "be.visible" on the list of external integrations

#REP-1670
Scenario: c) As a custodian, I can allow multiple extensions in external integrations

Given I'm logged at Reportnet page as 'userCustodian'
And I click on "Dataflow Reportnet Testing"
And I can click on element "DS-Test"
And I click on the tab "External integrations"
When I can click on "Create external integration"
Then I can "Create" the new external integration ""
| Test External integration multiple extension | Test description | ReportNetTesting | prefilling.fmw | IMPORT | csv, zip | p1 | 1 |
And The integration "Test External integration multiple extension" is "be.visible" on the list of external integrations

# REP-1488 
Scenario: d) As a custodian/steward, I want to be able to configure schema in the Export EU dataset and to get the attachments by field_value_id.

Given I'm logged at Reportnet page as 'userCustodian'
And I click on "Dataflow Reportnet Testing"
And I can click on element "DS-Test"
And I click on the tab "External integrations"
Then I can "Edit" the new external integration "Export EU Dataset"
| schema | dbo |

# REP-851 REP-925
@sanity 
Scenario: e) As a custodian, I want to configure an integration to pre-filled data for each reporter.

Given I'm logged at Reportnet page as 'userCustodian'
And I click on "Dataflow Reportnet Testing"
And I can click on element "DS-Test"
And I click on the tab "External integrations"
When I can click on "Create external integration"
Then I can "Create" the new external integration ""
| Test External integration | Test description | ReportNetTesting | prefilling.fmw | EXPORT | csv | p1 | 1 |
And The integration "Test External integration" is "be.visible" on the list of external integrations

# REP-925
Scenario: f) As a custodian, I want to configure an integration with duplicated name.

Given I'm logged at Reportnet page as 'userCustodian'
And I click on "Dataflow Reportnet Testing"
And I can click on element "DS-Test"
And I click on the tab "External integrations"
When I can click on "Create external integration"
Then I can "Create" the new external integration "duplicated"
| Test External integration | Test description | ReportNetTesting | prefilling.fmw | EXPORT | csv | p1 | 1 |

# REP-925
Scenario: g) As a custodian,  I see the list of external exports with the name

Given I'm logged at Reportnet page as 'userCustodian'
And I click on "Dataflow Reportnet Testing"
And I can click on element "DS-Test"
And I click on the tab "Export dataset data"
Then I can see the list of external "exports" with the name "Test External integration"