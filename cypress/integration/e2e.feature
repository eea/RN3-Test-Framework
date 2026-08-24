Feature: Main e2e testing with API calls


Scenario: a) As a data custodian I can add a new data flow with obligations

Given I'm logged at Reportnet api as 'userCustodian2'
Then I can create a new reporting dataflow with name 'DataFlow API Testing'
Then I can create a new schema with name 'DS-Test'
And I can get DataSchemaID
And I can create a Table
And I can get the idRecordSchema
Then I can add Field1 into the table
And I can add Field2 into the table
Then I can get APIkey from dataflow page
Then I can import data into the table
Then I can import file into the table
And I can get idDataSetSchema for creating a new QC rule
And I can get referenceId for creating a new QC rule
Then I can add new QC rule for table field
And I can validate data
Then I can wait until the validation finished
And I can check that the validation result has 6 error
And I can export data from the table
# And I can delete the data 
# Then I can get the ID and DataProviderID for lead reporter
# And I can add lead reporter
