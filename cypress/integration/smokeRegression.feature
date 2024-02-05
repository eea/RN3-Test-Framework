Feature: Reportnet smoke tests in Production

# @ignore
Scenario Outline: a) As a provider I can import data in dataset

Given I'm logged at production Reportnet page as "userProdProvider"
And I can click on dataflow "test export"
And I can click on element "Netherlands"
And I can click on element "test export"
Then I click on the import dataset data button
And I import a "zip" file "test export.zip" 
Then I see the message: "SUCCESS"
And the "action" "Notifications" is "be.visible"
Then I see the notification "Loaded data completed at Netherlands" in the notification received list

# @ignore
Scenario Outline: b) As a provider I can validate data in dataset

Given I'm logged at production Reportnet page as "userProdProvider"
And I can click on dataflow "test export"
And I can click on element "Netherlands"
Then I can click on element "test export"
And the "button" "Validate" is "be.enabled"
And I see the message: "INFO"
And I wait for notification
And the "action" "Notifications" is "be.visible"
Then I see the notification "Validating test export (Netherlands)" in the notification received list


Scenario Outline: c) As a provider I can release data to data collection

Given I'm logged at production Reportnet page as "userProdProvider"
And I can click on dataflow "test export"
And I can click on element "Netherlands"
Then I can click on element "Release to data collection"
And I can confirm release to data collection with "no restrict to public"


