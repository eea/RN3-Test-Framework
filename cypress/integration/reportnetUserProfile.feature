Feature: Reportnet User Profile - As a Reportnet User, I want to be able to manage my user preferences

# REP-191
Scenario Outline: a) As a Reportnet User I can add a user image (avatar)

Given  I'm logged at Reportnet page as "userProvider"
And I can see the user profile page
And I can add a user "<image>"

Examples:
  | image |
  |       |


# REP-191
Scenario Outline: b) As a Reportnet User I can change the user visual theme

Given  I'm logged at Reportnet page as "userProvider"
And I can see the theme is "<oldTheme>"
Then I can see the user profile page
And I can change the visual "<option>" from "<oldTheme>" to "<newTheme>"
And I can see the theme is "<newTheme>"

Examples:
  | theme | option | oldTheme | newTheme |
  | Light | theme  | Light    | Dark     |
