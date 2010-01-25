Scenario: voting
  Given these tweets exist:
        | from_user    | text                   |
        | a_user       | I'm having a crisis!   |
        | another_user | I'm having a sandwich! |
   When I go to the home page
    And I press "Report Crisis"
    And I follow "View Crises"
    # 'last hour' doesn't get tested properly, due to comparison
    # across time zones. see the timeframe scope in report.rb.
    # meanwhile, we use 'this week', which will still be wrong
    # for a while once a week.
    And I select "this week" from "timeframe"
    And I press "Filter Results"
   Then I should see only these tweets:
        | user         | content                |
        | a_user       | I'm having a crisis!   |
