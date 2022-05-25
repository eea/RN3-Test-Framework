Feature: Reportnet User Profile - As a Reportnet User, I want to be able to manage my user preferences

# REP-191
Scenario Outline: As a Reportnet User I can change the application date format

Given I'm logged at Reportnet page as user "<user>" and password "<password>"
And I can see the dateFormat on the "<dataflow>" as "<oldDate>"
Then I can see the user profile page
And I can change the visual "<option>" from "<fromFormat>" to "<toFormat>"
And the "action" "Dataflows" is "be.visible"
And I can see the dateFormat on the "<dataflow>" as "<newDate>"

Examples:
  | user         | password | option     | fromFormat | toFormat   | dataflow                   | oldDate    | newDate    |
  | testprovider | 1234     | dateFormat | YYYY-MM-DD | DD-MM-YYYY | Dataflow Reportnet Testing | YYYY-MM-DD | DD-MM-YYYY |


# REP-191
Scenario: As a Reportnet User I can change the default rows per page

Given I'm logged at Reportnet page as user "testprovider" and password "1234"
And I can click on "Dataflow Reportnet Testing"
And I can click on element "Spain"
And I can click on element "DS-Test"
And the "button" "Import table data" is "be.enabled"
And I import a file "testPagination.csv"
And I reload the page
And I am in "DS-Test" dataset
And the dataset table "Table1" has 10 records
And I can see the user profile page
When I can change the visual "defaultRows" from "10" to "5"
And the "action" "Dataflows" is "be.visible"
And I can click on "Dataflow Reportnet Testing"
And I can click on element "Spain"
And I can click on element "DS-Test"
Then the dataset table "Table1" has 5 records


# REP-191
Scenario Outline: As a Reportnet User I can add a user image (avatar)

Given I'm logged at Reportnet page as user "<user>" and password "<password>"
And I can see the user profile page
And I can add a user "<image>"

Examples:
  | user         | password | image |
  | testprovider | 1234     |       |



# REP-191
Scenario Outline: As a Reportnet User I can change the user visual theme

Given I'm logged at Reportnet page as user "<user>" and password "<password>"
And I can see the theme is "<oldTheme>"
Then I can see the user profile page
And I can change the visual "<option>" from "<oldTheme>" to "<newTheme>"
And I can see the theme is "<newTheme>"

Examples:
  | user         | password | theme | option | oldTheme | newTheme |
  | testprovider | 1234     | Light | theme  | Light    | Dark     |
