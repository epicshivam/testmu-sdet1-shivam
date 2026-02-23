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

## API Module - Version 1

Write Gherkin test cases for a REST API. I need to cover auth token validation, CRUD operations, error handling for 4xx and 5xx, rate limiting, and schema validation.

## API Module - Version 2

Act as an Expert API Test Automation Engineer. Generate comprehensive BDD test cases in Gherkin format for a REST API.

Cover these 5 specific areas:

Auth token validation (valid, invalid, expired)

CRUD operations (Create, Read, Update, Delete) for a specific resource, utilizing a Scenario Outline.

Error handling for client (4xx) and server (5xx) status codes.

Rate limiting (specifically HTTP 429 Too Many Requests).

JSON Schema validation for the response body.

Constraints:

Use standard Gherkin syntax and apply appropriate API-specific tags (e.g., @api, @auth, @schema).

Steps must explicitly reference HTTP methods (GET, POST, PUT, DELETE), status codes, and JSON payloads rather than abstract UI concepts.

Output only the raw Gherkin code without any introductory text.

## REST API Module Note 

My initial prompt (V1) produced tests that were too abstract and read like UI tests. They lacked the technical terminology necessary for backend automation. In V2, I framed the persona as an API Specialist and enforced constraints to include specific HTTP methods (GET, POST), exact status codes (like 429 for rate limiting), and explicitly requested JSON Schema validation, resulting in Gherkin that maps perfectly to API testing libraries like Playwright or RestAssured.