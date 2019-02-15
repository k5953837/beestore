Feature: 02 - Sign In

  Background:
    Given the normal user has already signed up
    Given the admin user has already signed up

  Scenario: [01-02-01] - Log with normal user
    1. User can find sign in page
    2. Show error messages when required info missing
    3. Show error messages when email is not exist
    4. Show error messages when password is not correct
    5. Show success messages when login successfully
    6. Normal use can't see Admin Menu
    # 1. User can find sign in page
    When the normal user goes to page - "/"
    Then the normal user should be at page - "/users/sign_in"
     And the normal user should see "BeeStore"
    Then the normal user should see "Welcome back! Make yourself at home."
    # 2. Show error messages when required info missing
    When the normal user presses "LOG IN" within "User Log In Form"
    Then the normal user should see "Invalid Email or password."
    # 3. Show error messages when email is not exist
    When the normal user fills in "Email" with "not_exist_user@example.com"
    When the normal user presses "LOG IN" within "User Log In Form"
    Then the normal user should see "Invalid Email or password."
    # 4. Show error messages when password is not correct
    When the normal user fills in "Email" with "normal_user@example.com"
    When the normal user fills in "Password" with "111111"
    When the normal user presses "LOG IN" within "User Log In Form"
    Then the normal user should see "Invalid Email or password."
    # 5. Show success messages when login successfully
    When the normal user fills in "Email" with "normal_user@example.com"
    When the normal user fills in "Password" with "12345678"
    When the normal user presses "LOG IN" within "User Log In Form"
    Then the normal user should see "Signed in successfully."
    # 6. Normal use can't see Admin Menu
    Then the normal user should see "normal_user@example.com"
     And the normal user clicks "normal_user@example.com"
    Then the normal user should see "Logout"
    Then the normal user should not see "Admin Menu"
    When the normal user clicks "Logout"
    Then the normal user should be at page - "/users/sign_in"

  Scenario: [01-02-02] - Log with admin user
    1. Show success messages when login successfully
    2. Admin use can see Admin Menu
    # 1. Show success messages when login successfully
    When the admin user goes to page - "/"
    When the admin user fills in "Email" with "admin_user@example.com"
    When the admin user fills in "Password" with "12345678"
    When the admin user presses "LOG IN" within "User Log In Form"
    Then the admin user should see "Signed in successfully."
    # 2. Admin use can see Admin Menu
    Then the admin user should see "admin_user@example.com"
     And the admin user clicks "admin_user@example.com"
    Then the admin user should see "Logout"
    Then the admin user should see "Admin Menu"
    When the admin user clicks "Logout"
    Then the admin user should be at page - "/users/sign_in"
