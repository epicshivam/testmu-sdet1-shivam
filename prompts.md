## Login Module – Version 1

You are a senior QA automation engineer designing regression coverage for a production-grade web login system.

Generate comprehensive, production-level Gherkin test scenarios for a secure login module.

System assumptions:
- Web-based application
- Username + password authentication
- Lock account after 5 consecutive failed login attempts
- Session expires after 15 minutes of inactivity
- Forgot password sends reset link to registered email

Requirements to cover:
1. Valid login
2. Invalid username
3. Invalid password
4. Both username and password invalid
5. Empty fields
6. Boundary input validation (min/max length)
7. SQL injection attempt
8. XSS attempt
9. Brute-force lockout behavior
10. Session expiry behavior
11. Forgot password flow

Constraints:
- Use proper Gherkin syntax (Feature, Scenario, Given, When, Then)
- Include both positive and negative scenarios
- Include security-focused scenarios
- Use realistic test steps
- Do not include explanations or commentary
- Output strictly valid Gherkin

The scenarios should reflect regression-level coverage, not superficial examples.


## Login Module – Version 2

You are a senior SDET designing maintainable BDD regression scenarios for a production-grade authentication system.

Generate structured Gherkin scenarios for a secure login module.

Enhancements required:
- Use Background section for common navigation steps
- Avoid repetitive Given steps
- Use parameterized examples where appropriate
- Separate functional scenarios from security scenarios
- Include clear expected system behavior after lockout
- Include expected HTTP/session behavior for expiry
- Ensure steps are automation-friendly (clear locators, clear actions)

System assumptions:
- Web-based application
- Username + password authentication
- Lock account after 5 consecutive failed login attempts
- Session expires after 15 minutes of inactivity
- Forgot password sends reset link to registered email

Cover:
- Positive scenarios
- Negative scenarios
- Security edge cases
- Boundary validation

Output strictly valid Gherkin.
No explanations.


### Observations After Version 1
- Output had repetitive navigation steps.
- Security scenarios were not clearly separated.
- Some steps were not automation-friendly.

### Improvements in Version 2
- Introduced Background block.
- Structured scenarios for maintainability.
- Added automation-friendly step clarity.