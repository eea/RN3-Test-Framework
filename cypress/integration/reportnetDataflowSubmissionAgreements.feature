Feature: Reportnet Submission Agreements - As an existing user on the Repornet system I want to test the actions with submission agreements

# REP-416 REP-415
Scenario: a) As a data custodian I can add a new data flow with obligations

Given I'm logged at Reportnet page as 'userCustodian'
And the "action" "Create new dataflow" is "be.visible"
Then I "Create" a reporting dataflow with name "Submission Agreement Test" and description "Description submission agreement test" and obligation "(C) Information on the assessment regime (Article 7)" with "noFilters"

# REP-416 REP-415
Scenario: b) As a data custodian the dataflow properties must show the information from ROD3

Given I'm logged at Reportnet page as 'userCustodian'
When I click on "Submission Agreement Test"
Then the "action" "Properties" is "be.visible"
And I can see the information from ROD3 with obligation "(C) Information on the assessment regime (Article 7)" and instrument "Air Quality Directive IPR"

# REP-416 REP-415
Scenario: c) As a data custodian I can edit the obligations on a dataflow 

Given I'm logged at Reportnet page as 'userCustodian'
When I filter the dataflow list by "name" with "Submission Agreement Test"
And I click on "Submission Agreement Test"
And the "action" "Edit" is "be.visible"
Then I can "Save" a dataflow with name "Submission Agreement Test Edited" and description "Description submission agreement test edited" and obligation "(C) Preliminary information on the assessment regime (Article 7)" with "noFilters"


# REP-416 REP-415
Scenario Outline:  d) As a Data Custodian User I can see the instruments and obligations on the dataflow list

Given I'm logged at Reportnet page as 'userCustodian'
Then I can see the "<submission>" on "Dataflow Reportnet Testing"

  Examples: 
    | submission                | 
    | (C) Information on the assessment regime (Article 7) | 
    | (C) Information on the assessment regime (Article 7) |
    
Scenario Outline: e) As a Data Provider User I can see the instruments and obligations on the dataflow list

Given I'm logged at Reportnet page as 'userProvider'
Then I can see the "<submission>" on "Dataflow Reportnet Testing"

  Examples: 
    | submission                | 
    | (C) Information on the assessment regime (Article 7) | 
    | (C) Information on the assessment regime (Article 7) |

# REP-416 REP-415
Scenario: f) As a data custodian I can add a new dataflow by searching obligations

Given I'm logged at Reportnet page as 'userCustodian'
And the "action" "Create new dataflow" is "be.visible"
Then I "Create" a reporting dataflow with name "Submission Agreement Search Test" and description "Description submission agreement search test" and obligation "(C) Preliminary information on the assessment regime (Article 7)" with "filters"

# REP-416 REP-415
Scenario: g) As a data custodian I can delete a data flow Submission Agreement Test Edited

Given I'm logged at Reportnet page as 'userCustodian'
And I click on "Submission Agreement Test Edited"
And the "action" "Edit" is "be.visible"
Then I can delete the dataflow "Submission Agreement Test Edited"
And I see the message: "SUCCESS"


# REP-416 REP-415
Scenario: h) As a data custodian I can delete a data flow Submission Agreement Search Test

Given I'm logged at Reportnet page as 'userCustodian'
And I click on "Submission Agreement Search Test"
And the "action" "Edit" is "be.visible"
Then I can delete the dataflow "Submission Agreement Search Test"
And I see the message: "SUCCESS"
