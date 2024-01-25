Feature: Reportnet Jobs Monitoring - As an existing user on the Repornet system I want to test the actions for Jobs Monitoring

#REP-156787
Scenario Outline: a) As an Admin  I can see the Jobs Monitoring window

Given I'm logged at Reportnet page as "userAdmin"
When the Jobs Monitoring button is "visible"
Then I click on the Jobs Monitoring button
And the Jobs Monitoring window is "display_status"

Examples:
   |visibility_status| display_status|
   |visible          | displayed     |

Scenario Outline: b) As a Custodian I can see the Jobs Monitoring window

Given I'm logged at Reportnet page as "userCustodian"
When the Jobs Monitoring button is "visible"
Then I click on the Jobs Monitoring button
And the Jobs Monitoring window is "display_status"

Examples:
   |visibility_status| display_status|
   |visible          | displayed     |

Scenario: c) As a Provider  I can see the Jobs Monitoring window

Given I'm logged at Reportnet page as "userProvider"
When the Jobs Monitoring button is "visible"
Then I click on the Jobs Monitoring button
And the Jobs Monitoring window is "display_status"

Examples:
   |visibility_status| display_status|
   |visible          | displayed     |


Scenario Outline: d) As an Admin  I can filter by Status in the Jobs monitoring window

Given I'm logged at Reportnet page as "userAdmin"
When the Jobs Monitoring button is "visible"
Then I click on the Jobs Monitoring button
And I can filter in Jobs monitoring window by "Status" with "<filter>" 

Examples:
   | filter      |  
   | FAILED      |
   | QUEUED      |
   | REFUSED     |
   | FINISHED    |
   | CANCELED    |
   | IN PROGRESS |

Scenario Outline: e) As an Custodian  I can filter by Status in the Jobs monitoring window

Given I'm logged at Reportnet page as "userCustodian"
When the Jobs Monitoring button is "visible"
Then I click on the Jobs Monitoring button
And I can filter in Jobs monitoring window by "Status" with "<filter>" 

Examples:
   | filter      |  
   | FAILED      |
   | QUEUED      |
   | REFUSED     |
   | FINISHED    |
   | CANCELED    |
   | IN PROGRESS |

Scenario Outline: f) As a Provider I can filter by Status in the Jobs monitoring window

Given I'm logged at Reportnet page as "userProvider"
When the Jobs Monitoring button is "visible"
Then I click on the Jobs Monitoring button
And I can filter in Jobs monitoring window by "Status" with "<filter>" 

Examples:
   | filter      |  
   | FAILED      |
   | QUEUED      |
   | REFUSED     |
   | FINISHED    |
   | CANCELED    |
   | IN PROGRESS |

Scenario Outline: g) As an Admin  I can filter by Type in the Jobs monitoring window

Given I'm logged at Reportnet page as "userAdmin"
When the Jobs Monitoring button is "visible"
Then I click on the Jobs Monitoring button
And I can filter in Jobs monitoring window by "Type" with "<filter>" 

Examples:
   | filter                |  
   | IMPORT                |
   | VALIDATION            |
   | RELEASE               |
   | EXPORT                |
   | COPY TO EU DATASET    |

Scenario Outline: h) As a Provider  I can filter by Type in the Jobs monitoring window

Given I'm logged at Reportnet page as "userProvider"
When the Jobs Monitoring button is "visible"
Then I click on the Jobs Monitoring button
And I can filter in Jobs monitoring window by "Type" with "<filter>" 

Examples:
   | filter                |  
   | IMPORT                |
   | VALIDATION            |
   | RELEASE               |
   | EXPORT                |
   | COPY TO EU DATASET    |

Scenario Outline: i) As a Custodian  I can filter by Type in the Jobs monitoring window

Given I'm logged at Reportnet page as "userCustodian"
When the Jobs Monitoring button is "visible"
Then I click on the Jobs Monitoring button
And I can filter in Jobs monitoring window by "Type" with "<filter>" 

Examples:
   | filter                |  
   | IMPORT                |
   | VALIDATION            |
   | RELEASE               |
   | EXPORT                |
   | COPY TO EU DATASET    |

Scenario: j) As a Custodian  I can filter by Job Id in the Jobs monitoring window

Given I'm logged at Reportnet page as "userCustodian"
When the Jobs Monitoring button is "visible"
Then I click on the Jobs Monitoring button
And I can filter in Jobs monitoring window by 'jobId' with '240'

Scenario: k) As an Admin  I can filter by Job Id in the Jobs monitoring window

Given I'm logged at Reportnet page as "userAdmin"
When the Jobs Monitoring button is "visible"
Then I click on the Jobs Monitoring button
And I can filter in Jobs monitoring window by 'jobId' with '240'

Scenario: l) As an Provider  I can filter by Job Id in the Jobs monitoring window

Given I'm logged at Reportnet page as "userProvider"
When the Jobs Monitoring button is "visible"
Then I click on the Jobs Monitoring button
And I can filter in Jobs monitoring window by 'jobId' with '240'