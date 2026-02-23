## Intial Prompt for generating base folder sturcture

Help me step by step to generate a folder structure in playwright/javascript that follow a basic production grade ready framework pattern.


## Login Module – Version 1

Write Gherkin test cases for a web application Login module. I need you to cover the following scenarios: valid login, invalid credentials, forgot password, session expiry, and brute-force lockout.

## Login Module – Version 2

Act as an Expert SDET. Generate comprehensive BDD test cases in Gherkin format for a web application's Login module.

Strictly cover these 5 scenarios:

Valid login

Invalid credentials

Forgot password

Session expiry

Brute-force lockout

Constraints:

Use standard Gherkin syntax (Feature, Background, Scenario, Given, When, Then).

Use a 'Scenario Outline' with an Examples table for the "invalid credentials" test to cover multiple variations (wrong username, wrong password, empty fields).

Apply appropriate test tags (e.g., @smoke, @regression, @security) to each scenario.

Ensure the steps are declarative (focusing on business behavior) rather than strictly imperative (clicking specific button IDs).
Output only the raw Gherkin code without any introductory text.

# Login Module Note 

My initial prompt (V1) produced overly simplistic Gherkin that lacked data-driven testing and proper organization. It didn't utilize Scenario Outlines for the invalid credentials, meaning I would have had to write duplicate code for different failure states. In V2, I applied persona framing ("Act as an Expert SDET"), enforced constraints for structural elements like tags and background steps, and explicitly requested a Scenario Outline with a data table, resulting in a much more scalable and professional feature file.