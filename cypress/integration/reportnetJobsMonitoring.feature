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

Given I'm logged at Reportnet3 page as "userCustodian2"
And I wait for enter
When the Jobs Monitoring button is "visible"
Then I click on the Jobs Monitoring button
And the Jobs Monitoring window is "display_status"

Examples:
   |visibility_status| display_status|
   |visible          | displayed     |

Scenario: c) As a Provider  I can see the Jobs Monitoring window

Given I'm logged at Reportnet page as "userProvider2"
When the Jobs Monitoring button is "visible"
Then I click on the Jobs Monitoring button
And the Jobs Monitoring window is "display_status"

Examples:
   |visibility_status| display_status|
   |visible          | displayed     |

Scenario Outline: aa) As an Admin  I can see the Jobs History window

Given I'm logged at Reportnet page as "userAdmin"
When the Jobs Monitoring button is "visible"
Then I click on the Jobs Monitoring button
And the Jobs Monitoring window is "display_status"
And I wait for enter
And I click on the History tab
And I wait for enter
Then I can see the message on the page "There are no jobs with the selected parameters"

Scenario Outline: bb) As a Custodian I can see the Jobs History window

Given I'm logged at Reportnet3 page as "userCustodian2"
And I wait for enter
When the Jobs Monitoring button is "visible"
Then I click on the Jobs Monitoring button
And the Jobs Monitoring window is "display_status"
And I wait for enter
And I click on the History tab
And I wait for enter
Then I can see the message on the page "There are no jobs with the selected parameters"

Scenario: cc) As a Provider  I can see the Jobs History window

Given I'm logged at Reportnet page as "userProvider2"
When the Jobs Monitoring button is "visible"
Then I click on the Jobs Monitoring button
And the Jobs Monitoring window is "display_status"
And I click on the History tab
And I wait for enter
Then I can see the message on the page "There are no jobs with the selected parameters"


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

Given I'm logged at Reportnet page as "userCustodian2"
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

Given I'm logged at Reportnet3 page as "userProvider2"
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

Given I'm logged at Reportnet3 page as "userProvider2"
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

Given I'm logged at Reportnet page as "userCustodian2"
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

Scenario Outline: dd) As an Admin  I can filter by Status in the Jobs History window

Given I'm logged at Reportnet page as "userAdmin"
When the Jobs Monitoring button is "visible"
Then I click on the Jobs Monitoring button
And I click on the History tab
And I can filter in Jobs monitoring window by "Status" with "<filter>" 

Examples:
   | filter      |  
   | FAILED      |
   | QUEUED      |
   | REFUSED     |
   | FINISHED    |
   | CANCELED    |
   | IN PROGRESS |

Scenario Outline: ee) As an Custodian  I can filter by Status in the Jobs History window

Given I'm logged at Reportnet page as "userCustodian2"
When the Jobs Monitoring button is "visible"
And I wait for enter
Then I click on the Jobs Monitoring button
And I click on the History tab
And I can filter in Jobs monitoring window by "Status" with "<filter>" 

Examples:
   | filter      |  
   | FAILED      |
   | QUEUED      |
   | REFUSED     |
   | FINISHED    |
   | CANCELED    |
   | IN PROGRESS |

Scenario Outline: ff) As a Provider I can filter by Status in the Jobs History window

Given I'm logged at Reportnet3 page as "userProvider2"
And I wait for enter
When the Jobs Monitoring button is "visible"
Then I click on the Jobs Monitoring button
And I click on the History tab
And I can filter in Jobs monitoring window by "Status" with "<filter>" 

Examples:
   | filter      |  
   | FAILED      |
   | QUEUED      |
   | REFUSED     |
   | FINISHED    |
   | CANCELED    |
   | IN PROGRESS |

Scenario Outline: gg) As an Admin  I can filter by Type in the Jobs History window

Given I'm logged at Reportnet page as "userAdmin"
When the Jobs Monitoring button is "visible"
Then I click on the Jobs Monitoring button
And I click on the History tab
And I can filter in Jobs monitoring window by "Type" with "<filter>" 

Examples:
   | filter                |  
   | IMPORT                |
   | VALIDATION            |
   | RELEASE               |
   | EXPORT                |
   | COPY TO EU DATASET    |

Scenario Outline: hh) As a Provider  I can filter by Type in the Jobs History window

Given I'm logged at Reportnet3 page as "userProvider2"
When the Jobs Monitoring button is "visible"
Then I click on the Jobs Monitoring button
And I click on the History tab
And I can filter in Jobs monitoring window by "Type" with "<filter>" 

Examples:
   | filter                |  
   | IMPORT                |
   | VALIDATION            |
   | RELEASE               |
   | EXPORT                |
   | COPY TO EU DATASET    |

Scenario Outline: ii) As a Custodian  I can filter by Type in the Jobs History window

Given I'm logged at Reportnet page as "userCustodian2"
When the Jobs Monitoring button is "visible"
Then I click on the Jobs Monitoring button
And I click on the History tab
And I can filter in Jobs monitoring window by "Type" with "<filter>" 

Examples:
   | filter                |  
   | IMPORT                |
   | VALIDATION            |
   | RELEASE               |
   | EXPORT                |
   | COPY TO EU DATASET    |   

Scenario: j) As a Custodian  I can filter by Job Id in the Jobs monitoring window

Given I'm logged at Reportnet page as "userCustodian2"
When the Jobs Monitoring button is "visible"
Then I click on the Jobs Monitoring button
And I can filter in Jobs monitoring window by 'jobId' with '240'

Scenario: k) As an Admin  I can filter by Job Id in the Jobs monitoring window

Given I'm logged at Reportnet page as "userAdmin"
When the Jobs Monitoring button is "visible"
Then I click on the Jobs Monitoring button
And I can filter in Jobs monitoring window by 'jobId' with '240'

Scenario: l) As an Provider  I can filter by Job Id in the Jobs monitoring window

Given I'm logged at Reportnet3 page as "userProvider2"
When the Jobs Monitoring button is "visible"
Then I click on the Jobs Monitoring button
And I can filter in Jobs monitoring window by 'jobId' with '240'

Scenario: jj) As a Custodian  I can filter by Job Id in the Jobs History window

Given I'm logged at Reportnet page as "userCustodian2"
When the Jobs Monitoring button is "visible"
Then I click on the Jobs Monitoring button
And I click on the History tab
And I can filter in Jobs monitoring window by 'jobId' with '10282'

Scenario: kk) As an Admin  I can filter by Job Id in the Jobs History window

Given I'm logged at Reportnet page as "userAdmin"
When the Jobs Monitoring button is "visible"
Then I click on the Jobs Monitoring button
And I click on the History tab
And I can filter in Jobs monitoring window by 'jobId' with '10282'

Scenario: ll) As an Provider  I can filter by Job Id in the Jobs History window

Given I'm logged at Reportnet3 page as "userProvider2"
When the Jobs Monitoring button is "visible"
Then I click on the Jobs Monitoring button
And I click on the History tab
And I can filter in Jobs monitoring window by 'jobId' with '10282'