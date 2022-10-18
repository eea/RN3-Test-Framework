Feature: Reportnet WebForm - As an existing user on the Repornet system I want to test the WebForms configuration

# REP-903 REP-921
Scenario: As a data custodian I can create new dataflow and dataset schema with a webform table

Given I'm logged at Reportnet page as "userCustodian"
And the "action" "Create new dataflow" is "be.visible"
And I can "Create" a dataflow with name "WebForm Test" and description "Description New Test" and obligation "(C) Information on the assessment regime (Article 7)" with "noFilters"
And I can click on "WebForm Test"
And I can click on element "New schema"
And I can "create" a dataset schema with name "DS-Test"


# REP-903 REP-921
Scenario: As a custodian, I want to configure the webform used in each dataset

Given I'm logged at Reportnet page as "userCustodian"
And I can click on "WebForm Test"
And I can click on element "DS-Test"
And I can click on "Configure webform"
And I select the "Governance Regulation Art. 13" webform developed in the system
When I change to "Webform" mode
Then I will see the webform configured


Scenario: As a data custodian I can delete a data flow

Given I'm logged at Reportnet page as "userCustodian"
And I can click on "WebForm Test"
And the "action" "Edit" is "be.visible"
Then I can delete the dataflow "WebForm Test"


#REP-1993
Scenario: As an admin I can manage webforms

Given I'm logged at Reportnet page as "userAdmin"
When the "action" "Manage webforms" is "be.visible"
And I can see the list of webforms
    | Governance Regulation | PaMs   |
    | National Systems      | Q&A    |
And I can add a new webform "test" and "Tables"
And the "button" "Select file" is "be.enabled"
And I upload the webform from file "Tables webform example.json"
Then I can see the list of webforms
    | test | Tables |
