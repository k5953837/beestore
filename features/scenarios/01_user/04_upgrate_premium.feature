Feature: 04 - Upgrade Premium

  Background:
    Given the admin user has already signed up
    Given the normal user has already signed up

  Scenario: [01-04]
    1. Normal user can browser products
    2. Normal user can upgrade to premium and see discount price
    # 1. Normal user can browser products
    When the admin user goes to page - "/"
    When the admin user fills in "Email" with "admin_user@example.com"
    When the admin user fills in "Password" with "12345678"
    When the admin user presses "LOG IN" within "User Log In Form"
     And the admin user clicks "admin_user@example.com"
     And the admin user clicks "Admin Menu"
    When the admin user clicks "NEW PRODUCT"
    When the admin user fills in "Name" with "Test Product"
    When the admin user fills in "Price" with "1000"
    When the admin user fills in "Discount" with "20"
    When the admin user attaches the file "test.jpg" to "Image"
    When the admin user presses "CREATE PRODUCT"
     And the admin user clicks "admin_user@example.com"
    Then the admin user clicks "Logout"
    When the normal user fills in "Email" with "normal_user@example.com"
    When the normal user fills in "Password" with "12345678"
    When the normal user presses "LOG IN" within "User Log In Form"
     And the normal user should see "Test Product $ 1000"
     And the normal user clicks product picture
     And the normal user should see "Test Product"
     And the normal user should see "$ 1000"
    # 2. Normal user can upgrade to premium and see discount price
     And the normal user should see "UPGRADE PREMIUM"
     And the normal user clicks "UPGRADE PREMIUM"
     And the normal user should see "Upgrade your membership to premium"
    When the normal user presses "UPGRADE PREMIUM"
     And the normal user should see "Congratulation to upgrade user to premium."
     And the normal user should not see "UPGRADE PREMIUM"
    When the normal user goes to page - "/"
     And the normal user should see "Test Product $ 1000 800"
     And the normal user clicks product picture
     And the normal user should see "Test Product"
     And the normal user should see "$ 1000 800"
