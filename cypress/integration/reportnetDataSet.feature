Feature: Reportnet Dataset - As an existing user on the Repornet system I want to test the actions with dataset data

@sanity
Scenario: Add data to dataset with Import

Given I'm logged at Reportnet page as user "testprovider" and password "1234"
And I can click on "Dataflow Reportnet Testing"
And I can click on element "Spain"
And I can click on element "DS-Test"
And the "button" "Import table data" is "be.enabled"
And I import a file "test.csv" to dataset
Then I see the message: "SUCCESS"
# Then the dataset table "Table1" has 2 records


@sanity
Scenario: As a data provider I can release to data collection

Given I'm logged at Reportnet page as user "testprovider" and password "1234"
And I can click on "Dataflow Reportnet Testing"
And I can click on element "Spain"
When I can click on element "Release to data collection"
And I can Release to data collection
And I see the message: "SUCCESS"
And I see the message: "Dataset copy released successfully"
And The user logout
Then I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "Dataflow Reportnet Testing"
And I can click on element "Data Collection - DS-Test"
And the dataset table "Table1" has 2 records


Scenario: Validate button is enabled for data Provider 

Given I'm logged at Reportnet page as user "testProvider" and password "1234"
And I can click on "Dataflow Reportnet Testing"
And I can click on element "Spain"
And I can click on element "DS-Test"
Then the "button" "Validate" is "be.enabled"


Scenario: Validate button is disabled for data Custodian

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "Dataflow Reportnet Testing"
And I can click on element "Spain"
And I can click on element "DS-Test"
Then the "button" "Validate" is "be.disabled"


@sanity
Scenario: Edit dataset table row

Given I'm logged at Reportnet page as user "testprovider" and password "1234"
And I can click on "Dataflow Reportnet Testing"
And I can click on element "Spain"
And I can click on element "DS-Test"
Then I can update the cell with the text "data2" to the text "123"


Scenario: Delete dataset table row

Given I'm logged at Reportnet page as user "testprovider" and password "1234"
And I can click on "Dataflow Reportnet Testing"
And I can click on element "Spain"
And I can click on element "DS-Test"
And the "button" "Import" is "be.enabled"
And I import a file "test.csv" to dataset
And I see the message: "SUCCESS"
And I reload the page
And the dataset table "Table1" has 4 records
When I delete the dataset table row 1
And I reload the page
Then the dataset table "Table1" has 3 records


Scenario: Paste data to dataset

Given I'm logged at Reportnet page as user "testprovider" and password "1234"
And I can click on "Dataflow Reportnet Testing"
And I can click on element "Spain"
And I can click on element "DS-Test"
And the "button" "Paste records" is "be.enabled"
And I paste the data from file "test_paste.txt"
And I reload the page
Then the dataset table "Table1" has 4 records


Scenario: Delete table data

Given I'm logged at Reportnet page as user "testprovider" and password "1234"
And I can click on "Dataflow Reportnet Testing"
And I can click on element "Spain"
And I can click on element "DS-Test"
And the "button" "Delete table data" is "be.enabled"
And I delete the table data
And I reload the page
Then the dataset table "Table1" has 0 records


