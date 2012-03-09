Feature: User examine site data
  User has need to examine the site data to
  determine the status and stuff.

  Scenario: User examines project listing
    Given a user is signed in
      Then the user should be on his or her dashbaord
      And the user should see "Active Projects"
