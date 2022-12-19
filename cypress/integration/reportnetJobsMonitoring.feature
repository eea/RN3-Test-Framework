Feature: Reportnet Jobs Monitoring - As an existing user on the Repornet system I want to test the actions for Jobs Monitoring

#REP-156787
Scenario Outline: a) As an Admin  I can see the Jobs Monitoring window

Given I'm logged at Reportnet page as "userAdmin"
When the Jobs Monitoring button is "visible"
Then I click on the Jobs Monitoring button
And the Jobs Monitoring window is "display_status"

Examples:
   |visibility_status| display_status|
   |visible          | displayed     |

Scenario Outline: b) As a Custodian I can see the Jobs Monitoring window

Given I'm logged at Reportnet page as "userCustodian"
When the Jobs Monitoring button is "visible"
Then I click on the Jobs Monitoring button
And the Jobs Monitoring window is "display_status"

Examples:
   |visibility_status| display_status|
   |visible          | displayed     |

Scenario Outline: c) As a Provider  I cannot see the Jobs Monitoring window

Given I'm logged at Reportnet page as "userProvider"
When the Jobs Monitoring button is "visible"
Then I click on the Jobs Monitoring button
And the Jobs Monitoring window is "display_status"

Examples:
   |visibility_status  | display_status    |
   |not visible        | not displayed     |