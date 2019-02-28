Feature: 02 - Update Product

  Background:
    Given the admin user has already signed up
    Given the normal user has already signed up

  Scenario: [02-02-01]
    1. Show Error when required parametter is missing
    2. Show Error when product Price is not numericality
    3. Show Error when product Price is not greater than 0
    4. Show Error when product Discount is not inclusion 1-100
    # 1. Show Error when required parametter is missing
    When the admin user goes to page - "/"
    When the admin user fills in "Email" with "admin_user@example.com"
    When the admin user fills in "Password" with "12345678"
    When the admin user presses "LOG IN" within "User Log In Form"
    And the admin user clicks "admin_user@example.com"
    And the admin user clicks "Admin Menu"
    When the admin user clicks "NEW PRODUCT"
    When the admin user fills in "Name" with "Test Product"
    When the admin user fills in "Price" with "666"
    When the admin user fills in "Discount" with "20"
    When the admin user attaches the file "test.jpg" to "Image"
    When the admin user presses "CREATE PRODUCT"
     And the admin user clicks "EDIT"
    When the admin user fills in "Name" with ""
    When the admin user fills in "Price" with ""
    When the admin user fills in "Discount" with ""
    When the admin user presses "UPDATE PRODUCT"
     And the admin user should see "Name can't be blank"
     And the admin user should see "Price can't be blank and Price is not a number"
     And the admin user should see "Discount can't be blank and Discount must be between 1 & 100"
    # 2. Show Error when product Price is not numericality
    When the admin user fills in "Price" with "string"
    When the admin user presses "UPDATE PRODUCT"
     And the admin user should see "Price is not a number"
    # 3. Show Error when product Price is not greater than 0
    When the admin user fills in "Price" with "0"
    When the admin user presses "UPDATE PRODUCT"
     And the admin user should see "Price must be greater than 0"
    # 4. Show Error when product Discount is not inclusion 1-100
    When the admin user fills in "Discount" with "101"
    When the admin user presses "UPDATE PRODUCT"
     And the admin user should see "Discount must be between 1 & 100"
    When the admin user fills in "Discount" with "-1"
    When the admin user presses "UPDATE PRODUCT"
     And the admin user should see "Discount must be between 1 & 100"

  Scenario: [02-02-02]
    1. Admin user can edit product
    # 1. Admin user can edit product
    When the admin user goes to page - "/"
    When the admin user fills in "Email" with "admin_user@example.com"
    When the admin user fills in "Password" with "12345678"
    When the admin user presses "LOG IN" within "User Log In Form"
     And the admin user clicks "admin_user@example.com"
     And the admin user clicks "Admin Menu"
    When the admin user clicks "NEW PRODUCT"
    When the admin user fills in "Name" with "Test Product"
    When the admin user fills in "Price" with "666"
    When the admin user fills in "Discount" with "20"
    When the admin user attaches the file "test.jpg" to "Image"
    When the admin user presses "CREATE PRODUCT"
     And the admin user should see "EDIT"
     And the admin user clicks "EDIT"
     And the admin user should see "Update Product"
    When the admin user fills in "Name" with "Test Product 2"
    When the admin user fills in "Price" with "10000"
    When the admin user attaches the file "test2.jpg" to "Image"
    When the admin user presses "UPDATE PRODUCT"
    When the admin user goes to page - "/"
     And the admin user should see "Test Product 2 $ 1000"
     And the normal user clicks product picture
     And the admin user should see "Test Product 2"
     And the admin user should see "$ 1000"
