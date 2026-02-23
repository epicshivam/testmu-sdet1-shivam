# 🤖 AI Usage Log

As per the assessment requirements, this log documents every AI tool utilized during the development of this framework, the specific tasks they assisted with, and the resulting outputs.

---

## Tool Used: ChatGPT, Gemini Pro, OpenRouter LLM API

### Task 1: Repository Setup & Scaffolding

* **What I used it for:** Validating the initial framework architecture and ensuring the Playwright/JavaScript folder structure adhered to industry best practices for a scalable SDET project.
* **What it produced:** Confirmation of the structural separation of concerns (e.g., isolating `tests/ui`, `tests/api`, `llm`, and `generated-tests`) and guidance on the mandatory first commit message highlighting AI usage.

### Task 2: Prompt Engineering for Test Generation

* **What I used it for:** Iterating on prompt design to generate high-quality, BDD-style Gherkin test cases for the Login, Dashboard, and REST API modules.
* **What it produced:**

  * The raw prompts logged in `prompts.md`.
  * The structured Gherkin feature files (`login_v2.feature`, `dashboard_v2.feature`, `api_v2.feature`).
  * Analytical notes detailing the progression from basic, imperative prompts to advanced, declarative prompts utilizing Scenario Outlines, constraints, and specific HTTP/UI parameters.

### Task 3: LLM Integration & Project Documentation

* **What I used it for:** Brainstorming the architectural flow for intercepting Playwright test failures and drafting the project's documentation.
* **What it produced:**

  * The structural logic for the `aiFailureHandler.js` using Playwright's `test.afterEach` hook to pass DOM context and error logs to the LLM.
  * The comprehensive `README.md` containing setup instructions, the rationale for choosing Option A (Failure Explainer), and future scaling concepts.

---

*Note: The actual LLM API call executed inside the test framework (Option A) uses mistralai/mistral-7b-instruct [Free Open Router LLM Model] to dynamically analyze test failures during execution.*
