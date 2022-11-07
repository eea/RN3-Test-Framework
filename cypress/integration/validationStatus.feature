Feature: Validations status button - As an existing user on the Repornet system I want to test the validations status button

#REP-151313
@ignore
Scenario Outline:  As a Data Custodian I can see the validations status window

Given I'm logged at Reportnet page as "userCustodian"
And the validations status button is "visible"
When I click on the validations status button
Then the validations status window is "display_status"
And dataset column has clickable links


Examples:
   |visibility_status| display_status|
   |visible          | displayed     |


@ignore
Scenario Outline:  As an Admin I can see the validations status window

Given I'm logged at Reportnet page as "userAdmin"
When the validations status button is "visible"
Then I click on the validations status button
And the validations status window is "display_status"
And dataset column has clickable links

Examples:
   |visibility_status| display_status|
   |visible          | displayed     |  
     
@ignore
Scenario: As an Observer I cannot see the validations status window

Given I'm logged at Reportnet page as "userObserver"
Then the validations status button is not visible

#REP-151313
Scenario:  As a Data Custodian I can redirect to the reporting dataset from the validation status window

Given I'm logged at Reportnet page as "userCustodian"
And the "action" "Create new dataflow" is "be.visible"
And  I "Create" a reporting dataflow with name "Validation Reportnet Testing" and description "Dataflow validation test" and obligation "(C) Information on the assessment regime (Article 7)" with "noFilters"
When I click on "Validation Reportnet Testing"
And I get the dataflow ID from the url
And I can click on element "New schema"
Then I can "create" a dataset schema with name "DS-Test"
And I can click on element "DS-Test"
And I can fill a dataset schema with name "Table1", description "description Table1" and with following fields
| table1f1 | description 1 | Number - Integer |  | true |
And the "button" "Validate" is "be.enabled"
And I see the message: "SUCCESS"
And I can go to the list dataflows page
And the validations status button is "visible"
And I click on the validations status button
And I filter by dataflowId in the validation status window
And the link redirects to the reporting dataset

