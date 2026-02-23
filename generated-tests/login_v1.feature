Feature: Login Module Authentication
  As a registered user
  I want to log into the web application
  So that I can access my account securely

Scenario: Successful login with valid credentials
    Given the user is on the login page
    When the user enters a valid username
    And the user enters the correct password
    And clicks on the login button
    Then the user should be redirected to the dashboard
    And a success message should be displayed

Scenario: Successful login with valid credentials using Enter key
    Given the user is on the login page
    When the user enters a valid username
    And the user enters the correct password
    And presses the Enter key
    Then the user should be redirected to the dashboard

Scenario: Login with incorrect password
    Given the user is on the login page
    When the user enters a valid username
    And enters an incorrect password
    And clicks on the login button
    Then an error message "Invalid username or password" should be displayed
    And the user should remain on the login page

Scenario: Login with unregistered username
    Given the user is on the login page
    When the user enters an unregistered username
    And enters any password
    And clicks on the login button
    Then an error message "Invalid username or password" should be displayed

Scenario: Login with empty fields
    Given the user is on the login page
    When the user clicks on the login button without entering credentials
    Then validation messages should be displayed for required fields

Scenario: Navigate to Forgot Password page
    Given the user is on the login page
    When the user clicks on the "Forgot Password" link
    Then the user should be redirected to the password reset page

Scenario: Submit forgot password with registered email
    Given the user is on the password reset page
    When the user enters a registered email address
    And clicks on the submit button
    Then a password reset link should be sent to the registered email
    And a confirmation message should be displayed

Scenario: Submit forgot password with unregistered email
    Given the user is on the password reset page
    When the user enters an unregistered email address
    And clicks on the submit button
    Then an error message "Email not found" should be displayed

Scenario: Automatic session expiry after inactivity
    Given the user is logged into the application
    When the user remains inactive for the configured session timeout period
    Then the session should expire
    And the user should be redirected to the login page
    And a message "Session expired. Please login again." should be displayed

Scenario: Access secured page after session expiry
    Given the user session has expired
    When the user tries to access a secured page URL directly
    Then the user should be redirected to the login page

Scenario: Account lockout after multiple failed login attempts
    Given the user is on the login page
    When the user enters an incorrect password 5 consecutive times
    Then the account should be temporarily locked
    And an error message "Account locked due to multiple failed attempts" should be displayed

Scenario: Login attempt during lockout period
    Given the user account is locked
    When the user attempts to login with correct credentials
    Then login should be denied
    And a message "Account is locked. Try again later." should be displayed

Scenario: Login after lockout duration expires
    Given the user account was locked
    And the lockout duration has passed
    When the user enters valid credentials
    Then the user should be able to login successfully