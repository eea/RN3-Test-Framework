Feature: Reportnet smoke tests in Transport

# @ignore
Scenario Outline: a) As a provider I can import data in dataset

Given I'm logged at production Reportnet page as "userTransProvider"
And I can click on dataflow "performance uat reporting vans"
And I can click on element "Detailed Data"
And the "button" "Import table data" is "be.enabled"
And I import a file "Item.csv"
Then I see the message: "SUCCESS"
And I wait for enter
And the "action" "Notifications" is "be.visible"
Then I see the notification "Loaded data completed at Netherlands" in the notification received list
And I can go to the dataflow page
And I can click on element "Aggregated Data"
And the "button" "Import table data" is "be.enabled"
And I import a file "VansAggregates.csv"
And I wait for enter
Then I see the message: "SUCCESS"
And the "action" "Notifications" is "be.visible"
Then I see the notification "Loaded data completed at Netherlands" in the notification received list

# @ignore
Scenario Outline: b) As a provider I can validate data in dataset

Given I'm logged at production Reportnet page as "userTransProvider"
And I can click on dataflow "performance uat reporting vans"
Then I can click on element "Detailed Data"
And the "button" "Validate" is "be.enabled"
And I see the message: "INFO"
And the "action" "Notifications" is "be.visible"
Then I see the notification "Validating Detailed Data (Netherlands)" in the notification received list
And I wait for validation
And I wait for importing the file
And I wait for importing the file


Scenario Outline: c) As a provider I can release data to data collection

Given I'm logged at production Reportnet page as "userTransProvider"
And I can click on dataflow "performance uat reporting vans"
Then I can click on element "Release to data collection"
And I can confirm release to data collection with "no restrict to public"


