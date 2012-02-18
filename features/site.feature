Feature: User examine site data

  User has need to examine the site data to
  determine the status and stuff.

  Scenario: User examines project listing
    Given a user is signed in
    Then the user goes to the site index
    #Then show me the page
    And sees "Site Index"
