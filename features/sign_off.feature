Feature: Sign Off

  Scenario: Sign Off

    Given I have a User Profile
    And   I sign on with valid credentials
    And   I am online
    When  I sign off
    Then  I am offline