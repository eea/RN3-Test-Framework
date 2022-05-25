Feature: Reportnet Web links - As an existing user on the Repornet system I want to test the actions with Web links

@sanity
Scenario: As a data custodian I can add weblinks to dataflow

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "Dataflow Reportnet Testing"
And I can click on element "Dataflow help"
And I can click on the tab "Web links"
And the "button" "Add" is "be.enabled"
And I add a webkink with description "New webLink" and url "www.google.es"
Then the table "Web links" has 1 records


Scenario: As a data custodian I can edit weblinks to dataflow

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "Dataflow Reportnet Testing"
And I can click on element "Dataflow help"
And I can click on the tab "Web links"
Then I can update the weblink with the description "Edit weblink" to the text "www.google2.com"


Scenario: As a data custodian I can remove weblinks to dataflow

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "Dataflow Reportnet Testing"
And I can click on element "Dataflow help"
And I can click on the tab "Web links"
When I "delete" the row 1
Then the table "Web links" has 0 records
