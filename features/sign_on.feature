Feature: Sign On

  Scenario: Valid Credentials

    Given I have a User Profile
    When  I sign on with valid credentials
    Then  I am online



  Scenario: Invalid Credentials

    Given I have a User Profile
    When  I try to sign on with invalid credentials
    Then  I am offline



  Scenario: Locked Account

    Given I have a User Profile
    When  I try to sign on with invalid credentials
    And   I try to sign on with invalid credentials
    And   I try to sign on with invalid credentials
    Then  I am locked out