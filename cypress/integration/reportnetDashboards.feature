Feature: Reportnet Dashboards - As an existing user on the Repornet system I want to test the actions with Dashboards

Scenario: Only as a data custodian I can see the dashboards

Given I'm logged at Reportnet page as 'userCustodian'
And I can click on "Dataflow Reportnet Testing"
Then the "action" "Dashboards" is "<visible>"

  Examples: 
  | visible     | 
  | be.visible  | 

Scenario: As a provider I cannot see the dashboards

Given I'm logged at Reportnet page as "userProvider"
And I can click on "Dataflow Reportnet Testing"
Then the "action" "Dashboards" is "<visible>"

  Examples: 
  | visible     | 
  | not.exist   | 


@sanity
Scenario: As a data custodian I see the Validation dashboards and Release status

Given I'm logged at Reportnet page as 'userCustodian'
And I can click on "Dataflow Reportnet Testing"
And I can click on element "Dashboards"
Then I can see the Release status dashboard and Validation dashboards
