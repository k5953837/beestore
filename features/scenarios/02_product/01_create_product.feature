Feature: 01 - Craete Product

  Background:
    Given the admin user has already signed up
    Given the normal user has already signed up

  Scenario: [02-01-01]
    1. Show Error when required parametter is missing
    2. Show Error when product Name is not uniqueness
    3. Show Error when product Price is not numericality
    4. Show Error when product Price is not greater than 0
    5. Show Error when product Discount is not inclusion 1-100
    # 1. Show Error when required parametter is missing
    When the admin user goes to page - "/"
    When the admin user fills in "Email" with "admin_user@example.com"
    When the admin user fills in "Password" with "12345678"
    When the admin user presses "LOG IN" within "User Log In Form"
     And the admin user clicks "admin_user@example.com"
     And the admin user clicks "Admin Menu"
     And the admin user should see "Product List"
     And the admin user should see "NEW PRODUCT"
    When the admin user clicks "NEW PRODUCT"
     And the admin user should see "Added New Product"
    When the admin user presses "CREATE PRODUCT"
     And the admin user should see "Name can't be blank"
     And the admin user should see "Price can't be blank and Price is not a number"
     And the admin user should see "Discount can't be blank and Discount must be between 1 & 100"
    # 2. Show Error when product Name is not uniqueness
    When the admin user fills in "Name" with "Test Product"
    When the admin user fills in "Price" with "666"
    When the admin user fills in "Discount" with "20"
    When the admin user attaches the file "test.jpg" to "Image"
    When the admin user presses "CREATE PRODUCT"
    When the admin user clicks "NEW PRODUCT"
    When the admin user fills in "Name" with "Test Product"
    When the admin user fills in "Price" with "666"
    When the admin user fills in "Discount" with "20"
    When the admin user attaches the file "test.jpg" to "Image"
    When the admin user presses "CREATE PRODUCT"
     And the admin user should see "Name has already been taken"
    # 3. Show Error when product Price is not numericality
    When the admin user fills in "Price" with "string"
    When the admin user presses "CREATE PRODUCT"
     And the admin user should see "Price is not a number"
    # 4. Show Error when product Price is not greater than 0
    When the admin user fills in "Price" with "0"
    When the admin user presses "CREATE PRODUCT"
     And the admin user should see "Price must be greater than 0"
    # 5. Show Error when product Discount is not inclusion 1-100
    When the admin user fills in "Discount" with "101"
    When the admin user presses "CREATE PRODUCT"
     And the admin user should see "Discount must be between 1 & 100"
    When the admin user fills in "Discount" with "-1"
    When the admin user presses "CREATE PRODUCT"
     And the admin user should see "Discount must be between 1 & 100"

  Scenario: [02-01-02]
    1. Admin user can create product
    # 1. Admin user can create product
    When the admin user goes to page - "/"
    When the admin user fills in "Email" with "admin_user@example.com"
    When the admin user fills in "Password" with "12345678"
    When the admin user presses "LOG IN" within "User Log In Form"
     And the admin user clicks "admin_user@example.com"
     And the admin user clicks "Admin Menu"
     And the admin user should see "Product List"
     And the admin user should see "NEW PRODUCT"
    When the admin user clicks "NEW PRODUCT"
     And the admin user should see "Added New Product"
    When the admin user fills in "Name" with "Test Product"
    When the admin user fills in "Price" with "666"
    When the admin user fills in "Discount" with "20"
    When the admin user attaches the file "test.jpg" to "Image"
    When the admin user presses "CREATE PRODUCT"
    When the admin user goes to page - "/"
     And the admin user should see "Test Product"
     And the admin user should see "$ 666"
     And the normal user clicks product picture
     And the admin user should see "Test Product"
     And the admin user should see "$ 666"
