Feature: 03 - Reset Password

  Background:
    Given the normal user has already signed up

  Scenario: [01-03]
    1. User can go to reset password page
    2. Show error messages when required info missing
    3. Show error messages when email is not exist
    4. Show success messages when login successfully
    5. User can receive reset password email
    6. User can log in after reset password
    # 1. User can find reset password page
    When the user goes to page - "/"
     And the user clicks "Forgot password"
    Then the user should be at page - "/users/password/new"
     And the user should see "BeeStore"
    Then the user should see "Forgot your password?"
    Then the user should see "Enter the email address you've registered with us, and we’ll send help shortly."
    # 2. Show error messages when required info missing
    When the user presses "RESET PASSWORD"
    Then the user should see "Email can't be blank"
    # 3. Show error messages when email is not exist
    When the user fills in "Email" with "not_exist_user@example.com"
    When the user presses "RESET PASSWORD"
    Then the user should see "Email not found"
    # 4. Show success messages when login successfully
    When the user fills in "Email" with "normal_user@example.com"
    When the user presses "RESET PASSWORD"
    Then the user should see "You will receive an email with instructions on how to reset your password in a few minutes."
    Then the user should be at page - "/users/sign_in"
    # 5. User can receive reset password email
     And "normal_user@example.com" should receive an emails with subject "Reset password instructions"
    When "normal_user@example.com" opens the email with subject "Reset password instructions"
    Then they should see "Someone has requested a link to change your password. You can do this through the link below." in the email body
    When they click the first link in the email
    Then the user should see "Ready to reset!"
    Then the user should see "Use 6 characters or more. Add numbers, lower and upper case letters for strength."
    When the user fills in "Password" with "111111"
    When the user fills in "Password Confirmation" with "111111"
     And the user presses "RESET PASSWORD"
    Then the user should be at page - "/"
    Then the user should see "Your password has been changed successfully. You are now signed in."
    # 6. User can log in after reset password
     And the user clicks "normal_user@example.com"
    Then the user clicks "Logout"
    When the user fills in "Email" with "normal_user@example.com"
    When the user fills in "Password" with "111111"
    When the user presses "LOG IN" within "User Log In Form"
    Then the user should see "Signed in successfully."
