@authentication @login
Feature: Login Module Authentication
As a registered user
I want to securely authenticate into the application
So that I can access protected resources

Background:
Given the user navigates to the login page
And the login service is available

@smoke @regression
Scenario: Valid login with correct credentials
Given a registered user exists with valid credentials
When the user submits valid username and password
Then the user should be authenticated successfully
And the user should be redirected to the dashboard
And an active session should be created

@regression
Scenario Outline: Login attempt with invalid credentials
Given a registered user exists with username "validUser"
When the user attempts to login with username "<username>" and password "<password>"
Then authentication should fail
And an appropriate error message should be displayed
And no session should be created

Examples:
  | username     | password      |
  | wrongUser    | validPass123  |
  | validUser    | wrongPass123  |
  |              | validPass123  |
  | validUser    |               |
  |              |               |

@regression
Scenario: Forgot password with registered email
Given a registered user exists with email "user@example.com
"
When the user requests a password reset using the registered email
Then a password reset link should be generated
And the reset link should be sent to the registered email address
And the user should see a confirmation message

@security @regression
Scenario: Session expiry after inactivity
Given the user is authenticated with an active session
When the user remains inactive beyond the configured session timeout
Then the session should expire automatically
And the user should be redirected to the login page
And access to protected resources should be denied until re-authentication

@security @regression
Scenario: Account lockout after multiple failed login attempts
Given a registered user exists with username "validUser"
And the maximum allowed failed login attempts is 5
When the user enters an incorrect password for 5 consecutive attempts
Then the account should be temporarily locked
And further login attempts should be blocked
And a lockout notification message should be displayed