Feature: Reportnet Web links - As an existing user on the Repornet system I want to test the actions with Web links

@sanity
Scenario: As a data custodian I can add a new data flow with obligations

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And the "action" "Create new dataflow" is "be.visible"
When I can "Create" a dataflow with name "Weblinks Reportnet Testing" and description "Dataflow weblinks test" and obligation "Agenda 21 National Report" with "filters"
| | | | | Agenda |
And I can click on "Weblinks Reportnet Testing"
And I can click on element "New schema"
And I can "create" a dataset schema with name "DS-Test"
When I can click on element "DS-Test"
And publicly available check is "not.be.disabled"
And I can toggle publicly available check
And I can fill a dataset schema with name "Table1", description "description Table1" and with following fields
 | Field1 | Field 1 description | Number - Integer | | true |
 | Field2 | Field 2 description | Text             | |      |
And I can go to the dataflow page
And I can click on element "Manage lead reporters"
And I can "add" a Data provider with Representative of "EEA Member countries" and account "testprovider@reportnet.net" and Data provider "Spain"
And I can click on element "Manage lead reporters"
Then I can see the representative "Spain" "testprovider@reportnet.net"


# REP-1229
@sanity
Scenario: As a data custodian I can add weblinks to dataflow

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "Weblinks Reportnet Testing"
And I can click on element "Dataflow help"
And I can click on the tab "Web links"
And the "button" "Add" is "be.enabled"
When I add a weblink with description "Test webLink" and url "www.google.es" marked as "private"
And the "button" "Add" is "be.enabled"
And I add a weblink with description "New webLink" and url "www.google.es" marked as "private"
Then the table "Web links" has 2 records
And The first record is "New webLink" and the last record is "Test webLink"


Scenario: As a data custodian I can edit weblinks to dataflow

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "Weblinks Reportnet Testing"
And I can click on element "Dataflow help"
And I can click on the tab "Web links"
Then I can update the weblink with the description "Edit weblink" to the text "www.google2.com"


Scenario: As a data custodian I can remove weblinks to dataflow

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "Weblinks Reportnet Testing"
And I can click on element "Dataflow help"
And I can click on the tab "Web links"
When I "delete" the row 1
Then the table "Web links" has 1 records


#REP-1685
Scenario: As a custodian/steward, I want to be able to set the links as public

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "Weblinks Reportnet Testing"
And I can click on element "Dataflow help"
And I can click on the tab "Web links"
And the "button" "Add" is "be.enabled"
When I add a weblink with description "Public webLink" and url "www.google.es" marked as "public"


@sanity
Scenario: As a data custodian I can create data collections

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "Weblinks Reportnet Testing"
And I can click on element "Create data collections"
Then I can create data collections with a technical acceptance step for the reporter submissions and "public"
And I see the message: "SUCCESS"


#REP-1685
Scenario: As a custodian/steward I can see all the public links in the dataflow public page as extra information if the dataflow is public

Given I'm in Reportnet page
And I can click on "View by obligation dataflow"
And I "can" see the publicly dataflow "Weblinks Reportnet Testing"
And I can see for dataflow "Weblinks Reportnet Testing" the instrument "Agenda 21 National Report", status "Open"
And I can click on "Weblinks Reportnet Testing"
Then the public table "Web links" has 1 records
And I login as user "testcustodian" and password "1234"
