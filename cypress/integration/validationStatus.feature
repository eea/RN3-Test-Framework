Feature: Validations status button - As an existing user on the Repornet system I want to test the validations status button

#REP-151313
Scenario Outline:  As a Data Custodian I can see the validations status window

Given I'm logged at Reportnet page as "userCustodian"
When the validations status button is "visible"
Then I click on the validations status button
And the validations status window is "display_status"
And dataset column has clickable links

Examples:
   |visibility_status| display_status|
   |visible          | displayed     |


 
Scenario Outline:  As an Admin I can see the validations status window

Given I'm logged at Reportnet page as "userAdmin"
When the validations status button is "visible"
Then I click on the validations status button
And the validations status window is "display_status"
And dataset column has clickable links

Examples:
   |visibility_status| display_status|
   |visible          | displayed     |  
     

Scenario: As an Observer I cannot see the validations status window

Given I'm logged at Reportnet page as "userObserver"
Then the validations status button is not visible