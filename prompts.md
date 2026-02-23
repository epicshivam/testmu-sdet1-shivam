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

## Dashboard Module – Version 1

Write Gherkin test cases for a web application's Dashboard. I need scenarios for widget loading, data accuracy, filter and sort behavior, responsive layout, and permission-based visibility.

## Dashboard Module - Version 2

Act as a Senior Test Automation Engineer. Generate comprehensive BDD test cases in Gherkin format for a platform's Dashboard module.

Cover these 5 specific areas:

Asynchronous widget loading states

Data accuracy (matching dashboard metrics to source data)

Filter/sort behavior (using a Scenario Outline for different column sorts)

Responsive layout (testing across different viewport sizes)

Permission-based visibility (Admin vs. Standard User roles)

Constraints:

Use proper Gherkin syntax with appropriate tags (e.g., @ui, @data, @roles).

Ensure the responsive layout scenario explicitly mentions standard viewport sizes (e.g., mobile, tablet, desktop).

Keep steps declarative, focusing on the business logic and user observation rather than low-level UI clicks.
Output only the raw Gherkin code.

# Dashboard Module Note 

My first prompt (V1) resulted in very generic tests. For example, it wrote a responsive layout test but didn't define any viewport dimensions, which is useless for automation. It also didn't specify roles for the permission test. In V2, I engineered the prompt to explicitly demand multiple viewports (mobile, tablet, desktop) via a Scenario Outline and specifically requested a comparison between "Admin" and "Standard User" roles, making the resulting Gherkin much closer to what a real SDET would write.