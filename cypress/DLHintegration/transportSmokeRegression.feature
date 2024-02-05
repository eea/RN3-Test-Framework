Feature: Reportnet smoke tests in Transport

# @ignore
Scenario Outline: a) As a provider I can import data in dataset

Given I'm logged at production Reportnet page as "userTransProvider"
And I can click on dataflow "performance uat reporting cars"
And I can click on element "IMPORTED_Detailed Data"
Then I click on the import dataset data button
And I import a "zip" file "IMPORTED_Detailed Data.zip" 
Then I see the message: "SUCCESS"
And the "action" "Notifications" is "be.visible"
Then I see the notification "Loaded data completed at Netherlands" in the notification received list
And I can go to the dataflow page
And I can click on element "IMPORTED_Aggregated Data"
Then I click on the import dataset data button
And I import a "zip" file "IMPORTED_Aggregated Data.zip" 
Then I see the message: "SUCCESS"
And the "action" "Notifications" is "be.visible"
Then I see the notification "Loaded data completed at Netherlands" in the notification received list

# @ignore
Scenario Outline: b) As a provider I can validate data in dataset

Given I'm logged at production Reportnet page as "userTransProvider"
And I can click on dataflow "performance uat reporting cars"
Then I can click on element "IMPORTED_Detailed Data"
And the "button" "Validate" is "be.enabled"
And I see the message: "INFO"
And the "action" "Notifications" is "be.visible"
Then I see the notification "Validating IMPORTED_Detailed Data (Netherlands)" in the notification received list
And I wait for validation
And I wait for importing the file


Scenario Outline: c) As a provider I can release data to data collection

Given I'm logged at production Reportnet page as "userTransProvider"
And I can click on dataflow "performance uat reporting cars"
Then I can click on element "Release to data collection"
And I can confirm release to data collection with "no restrict to public"


