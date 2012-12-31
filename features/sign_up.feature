Feature: Sign Up

  Scenario: Valid Sign Up

    When I sign up with valid credentials
    Then I am online



  Scenario: Sign Up with Duplicate Email

    When I try to sign up with a duplicate email
    Then I receive a duplicate email error



  Scenario: Sign Up with Invalid Email

    When I try to sign up with an invalid email address
    Then I receive an invalid email error



  Scenario: Sign Up with Missing Email

    When I try to sign up with a missing email address
    Then I receive an missing email error



#  Scenario: Sign Up with Missing Password
#
#    When I try to sign up with a missing password
#    Then I receive a missing password error