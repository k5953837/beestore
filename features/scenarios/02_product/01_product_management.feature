Feature: 01 - Product Management

  Background:
    Given the admin user has already signed up
    Given the normal user has already signed up

  Scenario: [02-01]
    1. Show Error when required parametter is missing
    2. Admin user can create product
    3. Admin user can edit product
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
    # 2. Admin user can create product
    When the admin user fills in "Name" with "Test Product"
    When the admin user fills in "Price" with "666"
    When the admin user attaches the file "test.jpg" to "Image"
    When the admin user presses "CREATE PRODUCT"
    When the admin user goes to page - "/"
     And the admin user should see "Test Product $ 666"
    When the admin user goes to page - "/products/1"
     And the admin user should see "Test Product"
     And the admin user should see "$ 666"
    # 3. Admin user can edit product
     And the admin user clicks "admin_user@example.com"
     And the admin user clicks "Admin Menu"
     And the admin user should see "EDIT"
     And the admin user clicks "EDIT"
     And the admin user should see "Update Product"
    When the admin user fills in "Name" with "Test Product 2"
    When the admin user fills in "Price" with "10000"
    When the admin user attaches the file "test2.jpg" to "Image"
    When the admin user presses "UPDATE PRODUCT"
    When the admin user goes to page - "/"
     And the admin user should see "Test Product 2 $ 1000"
    When the admin user goes to page - "/products/1"
     And the admin user should see "Test Product 2"
     And the admin user should see "$ 1000"
