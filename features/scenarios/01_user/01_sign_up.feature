Feature: 01 - Sign Up

  Background:
    Given the normal user has already signed up

  Scenario: [01-01]
    1. User can find sign up page
    2. Show error messages when required info missing
    3. Show error messages when email is already token
    4. Show scuccess messages user can register as a normal user
    # 1. User can find sign up page
    When the user goes to page - "/"
     And the user clicks "SIGN UP"
    Then the user should be at page - "/users/sign_up"
     And the user should see "BeeStore"
    Then the user should see "Hi, let's get to know each other."
    # 2. Show error messages when required info missing
    When the user presses "SIGN UP"
    Then the user should see "Email can't be blank"
     And the user should see "Password can't be blank"
    # 3. Show error messages when email is already token
    When the user fills in "Email" with "normal_user@example.com"
    When the user fills in "Password" with "123456"
    When the user fills in "Password Confirmation" with "123456"
    When the user presses "SIGN UP"
     And the user should see "Email has already been taken"
    # 4. Show scuccess messages User can register as a normal user
    When the user fills in "Email" with "test_user@example.com"
    When the user fills in "Password" with "123456"
    When the user fills in "Password Confirmation" with "123456"
    When the user presses "SIGN UP"
     And the user should see "Welcome! You have signed up successfully."
