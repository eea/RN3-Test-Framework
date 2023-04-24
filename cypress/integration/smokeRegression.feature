Feature: Reportnet smoke tests in Production

Scenario Outline: a) As a provider  I can import data in dataset

Given I'm logged at production Reportnet page as "userProdProvider"
And I can click on dataflow "test export"
And I can click on element "test export"
Then I click on the import dataset data button
And I import a "zip" file "test export.zip" 