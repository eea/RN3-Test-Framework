Feature: Reportnet Dashboards - As an existing user on the Repornet system I want to test the actions with Dashboards

Scenario Outline: Only as a data custodian I can see the dashboards

Given I'm logged at Reportnet page as user "<user>" and password "<password>"
And I can click on "Dataflow Reportnet Testing"
Then the "action" "Dashboards" is "<visible>"

  Examples: 
    | user          | password | visible     | 
    | testprovider  | 1234     | not.exist | 
    | testcustodian | 1234     | be.visible  | 


@sanity
Scenario: As a data custodian I see the Validation dashboards and Release status

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "Dataflow Reportnet Testing"
And I can click on element "Dashboards"
Then I can see the Release status dashboard and Validation dashboards
