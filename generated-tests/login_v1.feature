Feature: Production-Grade Web Login System Regression Coverage
  As a registered user
  I want to securely authenticate with the system
  So that I can access my account and protected resources

  Background:
    Given the web application is running and accessible
    And the user navigates to the login page

  Scenario: 1. Successful login with valid credentials
    Given the user has an active account with username "active_user" and password "ValidP@ssw0rd123!"
    When the user enters the username "active_user"
    And the user enters the password "ValidP@ssw0rd123!"
    And the user clicks the login button
    Then the user should be successfully authenticated
    And the system should redirect the user to the secure dashboard
    And an active session token should be generated in the browser cookies

  Scenario Outline: 2, 3, 4, 5. Login failures due to invalid credentials or empty fields
    When the user enters the username "<username>"
    And the user enters the password "<password>"
    And the user clicks the login button
    Then the user should not be authenticated
    And the system should display the error message "<expected_error>"
    And the user should remain on the login page
    And no session token should be generated

    Examples:
      | username      | password          | expected_error                   |
      | active_user   | WrongPassword1!   | Invalid username or password     |
      | unknown_user  | ValidP@ssw0rd123! | Invalid username or password     |
      | unknown_user  | WrongPassword1!   | Invalid username or password     |
      |               | ValidP@ssw0rd123! | Username field cannot be empty   |
      | active_user   |                   | Password field cannot be empty   |
      |               |                   | Username and password required   |

  Scenario Outline: 6. Boundary input validation for username and password lengths
    When the user enters the username "<username>"
    And the user enters the password "<password>"
    And the user clicks the login button
    Then the user should not be authenticated
    And the system should display the validation error "<expected_error>"

    Examples:
      | username                                             | password                                                                                                                                  | expected_error                                      |
      | ab                                                   | ValidP@ssw0rd123!                                                                                                                         | Username must be between 3 and 50 characters        |
      | thisusernameiswaytoolongandexceedsthemaximumlength51 | ValidP@ssw0rd123!                                                                                                                         | Username must be between 3 and 50 characters        |
      | active_user                                          | Short1!                                                                                                                                   | Password must be between 8 and 128 characters       |
      | active_user                                          | SuperLongPasswordThatExceedsTheMaximumAllowedLengthOfOneHundredAndTwentyEightCharactersByBeingUnnecessarilyAndExcessivelyLongString12345! | Password must be between 8 and 128 characters       |

  Scenario Outline: 7, 8. Security validation against SQL injection and Cross-Site Scripting (XSS)
    When the user enters the username "<malicious_username>"
    And the user enters the password "<malicious_password>"
    And the user clicks the login button
    Then the user should not be authenticated
    And the application should safely sanitize or reject the input
    And the system should display the generic error message "Invalid username or password"
    And a security event should be logged in the system audit trail

    Examples:
      | malicious_username             | malicious_password             |
      | admin' OR '1'='1               | password                       |
      | admin" OR 1=1 --               | password                       |
      | active_user                    | ' OR '1'='1                    |
      | <script>alert('xss')</script>  | ValidP@ssw0rd123!              |
      | active_user                    | "><img src=x onerror=alert(1)> |

  Scenario: 9. Account lockout after 5 consecutive failed login attempts (Brute-force protection)
    Given the user has an active account with username "bruteforce_target"
    And the account is currently unlocked
    When the user attempts to log in with an incorrect password 5 times consecutively
    Then the system should immediately lock the account "bruteforce_target"
    And the system should display the error message "Account locked due to 5 consecutive failed attempts."
    When the user attempts to log in with the correct password "ValidP@ssw0rd123!" on the 6th attempt
    Then the user should not be authenticated
    And the system should display the error message "Account locked. Please reset your password or contact support."

  Scenario: 10. Session expiration after 15 minutes of inactivity
    Given the user is successfully logged into the application
    And the user is currently viewing the secure dashboard
    When the user remains completely inactive for 15 minutes and 1 second
    And the user attempts to click a link to view user profile details
    Then the server should terminate the user's active session
    And the system should automatically redirect the user to the login page
    And the system should display the informative message "Your session has expired due to 15 minutes of inactivity. Please log in again."

  Scenario: 11a. Forgot password flow with a registered email address
    Given the user clicks on the "Forgot Password" link on the login page
    And the system navigates to the password recovery page
    When the user enters a registered email address "registered_user@example.com"
    And the user clicks the "Send Reset Link" button
    Then the system should generate a secure, time-bound, single-use password reset token
    And the system should dispatch a password reset email to "registered_user@example.com"
    And the system should display the message "If an account exists for that email, a password reset link has been sent."

  Scenario: 11b. Forgot password flow with an unregistered email address (Prevent User Enumeration)
    Given the user clicks on the "Forgot Password" link on the login page
    And the system navigates to the password recovery page
    When the user enters an unregistered email address "unregistered_user@example.com"
    And the user clicks the "Send Reset Link" button
    Then the system should not dispatch any email
    And the system should display the exact same message "If an account exists for that email, a password reset link has been sent."