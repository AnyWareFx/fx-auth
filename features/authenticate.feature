Feature: Authenticate

  Scenario: Session Times Out

    Given I have a User Profile
    And   I sign on with valid credentials
    When  My session times out
    Then  I am offline
