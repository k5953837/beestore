Feature: 04 - Upgrade Premium

  Background:
    Given the normal user has already signed up

  Scenario: [01-04]
    1. Normal user can upgrade to premium
    # 1. Normal user can upgrade to premium
    When the normal user goes to page - "/"
    When the normal user fills in "Email" with "normal_user@example.com"
    When the normal user fills in "Password" with "12345678"
    When the normal user presses "LOG IN" within "User Log In Form"
     And the normal user should see "UPGRADE PREMIUM"
     And the normal user clicks "UPGRADE PREMIUM"
     And the normal user should see "Upgrade your membership to premium"
    When the normal user presses "UPGRADE PREMIUM"
     And the normal user should see "Congratulation to upgrade user to premium."
     And the normal user should not see "UPGRADE PREMIUM"
