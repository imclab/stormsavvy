Feature: User examine site data
  User has need to examine the site data to
  determine the status and stuff.

  Scenario: User examines project listing
    Given a user is signed in
    And the user goes to the site index
    Then the "user" should be on the "index" page
