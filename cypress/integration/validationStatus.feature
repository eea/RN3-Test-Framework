Feature: Validations status button - As an existing user on the Repornet system I want to test the validations status button

#REP-151313
Scenario Outline:  As a Reportnet User I can see the validations status window

Given I'm logged at Reportnet page as user "<user>" and password "<password>"
When the validations status button is "visible"
Then I click on the validations status button
And the validations status window is "display_status"
And dataset column has clickable links

Examples:
| user               | password     | visibility_status      | display_status|
| te.custodian       | 1234         | visible                | displayed    |
| reportnet_admin    | admin        | not visible            | displayed    | 

Scenario: As an Observer I cannot see the validations status window

Given I'm logged at Reportnet page as user "te.observer" and password "1234"
Then the validations status button is not visible