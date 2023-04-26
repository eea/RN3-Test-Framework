Feature: Reportnet smoke tests in Production

Scenario Outline: a) As a provider I can import data in dataset

Given I'm logged at production Reportnet page as "userProdProvider"
And I can click on dataflow "test export"
And I can click on element "Netherlands"
And I can click on element "test export"
Then I click on the import dataset data button
And I import a "zip" file "test export.zip" 

Scenario Outline: b) As a provider I can validate data in dataset

Given I'm logged at production Reportnet page as "userProdProvider"
And I can click on dataflow "test export"
And I can click on element "Netherlands"
Then I can click on element "test export"
And the "button" "Validate" is "be.enabled"

Scenario Outline: c) As a provider I can release data to data collection

Given I'm logged at production Reportnet page as "userProdProvider"
And I can click on dataflow "test export"
And I can click on element "Netherlands"
Then I can click on element "Release to data collection"
And I can confirm release to data collection with "no restrict to public"


