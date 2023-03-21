Feature: Reportnet smoke tests in Production

Scenario Outline: a) As an Admin  I can see the Jobs Monitoring window

Given I'm logged at production Reportnet page as "userProdAdmin"
When the Jobs Monitoring button is "visible"
Then I click on the Jobs Monitoring button
And the Jobs Monitoring window is "display_status"

Examples:
   |visibility_status| display_status|
   |visible          | displayed     |