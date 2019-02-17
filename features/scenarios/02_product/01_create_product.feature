Feature: 01 - Product Management

  Background:
    Given the admin user has already signed up
    Given the normal user has already signed up

  Scenario: [01-01]
    1. Admin user can create product
    2. Normal user can see product
    # 1. Admin user can create product
    When the admin user goes to page - "/"
    When the admin user fills in "Email" with "admin_user@example.com"
    When the admin user fills in "Password" with "12345678"
    When the admin user presses "LOG IN" within "User Log In Form"
     And the admin user clicks "admin_user@example.com"
     And the admin user clicks "Admin Menu"
     And the admin user should see "Product List"
     And the admin user should see "New Product"
    When the admin user clicks "New Product"
     And the admin user should see "Added New Product"
    When the admin user fills in "Name" with "Test Product"
    When the admin user fills in "Price" with "666"
    When the admin user attaches the file "test.jpg" to "Image"
    When the admin user presses "Create Product"
    When the user goes to page - "/admin/products"
    # 2. Normal user can see product
     And the admin user clicks "admin_user@example.com"
     And the admin user clicks "Logout"


    # 1. User can find sign up page
    # When the user goes to page - "/"
    # And the user clicks "SIGN UP"
    # Then the user should be at page - "/users/sign_up"
    # And the user should see "BeeStore"
    # Then the user should see "Hi, let's get to know each other."
    # # 2. Show error messages when required info missing
    # When the user presses "SIGN UP"
    # Then the user should see "Email can't be blank"
    # And the user should see "Password can't be blank"
    # # 3. Show error messages when email is already token
    # When the user fills in "Email" with "normal_user@example.com"
    # When the user fills in "Password" with "123456"
    # When the user fills in "Password confirmation" with "123456"
    # When the user presses "SIGN UP"
    # And the user should see "Email has already been taken"
    # # 4. Show scuccess messages User can register as a normal user
    # When the user fills in "Email" with "test_user@example.com"
    # When the user fills in "Password" with "123456"
    # When the user fills in "Password confirmation" with "123456"
    # When the user presses "SIGN UP"
    # And the user should see "Welcome! You have signed up successfully."
