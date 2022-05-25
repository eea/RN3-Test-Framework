Feature: Reportnet Communication - As an existing user on the Repornet system I want to test the actions with communications

#REP-944
Scenario: As a custodian, I want to be able to communicate with lead reporters of a country.

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "Dataflow Reportnet Testing"
And I can click on element "Technical feedback"
When I select the country "Spain" 
Then I can "send" the message "Test communication"
And I can "send" the message "Test message"


#REP-1314
Scenario: As a custodian, I can delete a message

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "Dataflow Reportnet Testing"
And I can click on element "Technical feedback"
When I select the country "Spain"
Then I can "delete" the message "Test message" 


#REP-1314
Scenario: As a custodian, I can attach a file

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
And I can click on "Dataflow Reportnet Testing"
And I can click on element "Technical feedback"
When I select the country "Spain" 
And the "button" "Attach file" is "be.enabled"
Then I import a file "importLeadReporters.csv"

#REP-1839
Scenario: As an admin, I can send system notification to all users

Given I'm logged at Reportnet page as user "test.admin" and password "1234"
And the "action" "System notifications" is "be.visible"
When I create a system notification with "testMessage" message and "INFO" level and active "enabled"
Then I see the notification "testMessage" in the system notifications list


#REP-1839
Scenario: As a custodian, I can see a system notification sent by an admin

Given I'm logged at Reportnet page as user "testcustodian" and password "1234"
Then I can see a system notification "testMessage" sent by an Admin


#REP-1839
Scenario: As an admin, I can delete a system notification

Given I'm logged at Reportnet page as user "test.admin" and password "1234"
And the "action" "System notifications" is "be.visible"
Then I delete a system notification with "testMessage" message
