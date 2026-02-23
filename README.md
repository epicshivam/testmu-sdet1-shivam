# 🚀 TestMu AI SDET-1 Challenge: AI-Powered Test Framework

Welcome to my submission for the TestMu AI-Native Quality Engineering Challenge.

This isn't a theory test[cite: 4]; this is a practical implementation of an AI-driven testing framework. Instead of just throwing a standard failure exception, this Playwright setup actively queries an LLM to figure out **why** a test failed and provides a plain English fix.

## 🛠️ Tech Stack

* **Framework:** Playwright & JavaScript
* **AI Integration:** mistralai/mistral-7b-instruct [Free Open Router LLM Model]
* **Target App:** The Internet Herokuapp

---

## 🏃‍♂️ How to Run It

I've kept the setup straight to the point. Just follow these steps:

**1. Clone the repository**

```bash
git clone [https://github.com/epicshivam/testmu-sdet1-shivam.git](https://github.com/epicshivam/testmu-sdet1-shivam.git)
cd testmu-sdet1-shivam
```

**2. Install dependencies**

```bash
npm install
```

**3. Add your AI API Key**
Create a `.env` file in the root directory and securely add your API key:

```bash
OPENAI_API_KEY=your_api_key_here
```

**4. Run the tests**
Watch the tests execute. I have intentionally included a failing test so you can see the LLM integration in action.

```bash
npx playwright test
```

**5. View the AI-enhanced report**
Open the HTML report to see the AI's explanation attached directly to the failed test results.

```bash
npx playwright show-report
```

---

## 🤖 The Core Feature: Option A (Failure Explainer)

For the core LLM integration, I chose to build Option A: The Failure Explainer.
+1

How it works: When a test fails, the framework automatically intercepts the error message and the page state. It sends this data via a real, unmocked API call to an LLM. The LLM responds with a human-readable explanation of the bug and a suggested fix, which is then dynamically attached to the Playwright HTML report.
+2

Why I chose this over Flaky Test Classification:
I chose this because getting real-time debugging assistance provides immediate, tangible value during the active development cycle. It accelerates the feedback loop for engineers, saving the time usually spent digging through the DOM or deciphering cryptic stack traces. It shifts the QA mindset closer to proactive development.

---

## 🚀 What I'd Build Next (With More Time)

If I had more time to expand this framework, here is what I would tackle next to push it further towards a full engineering solution:

**Self-Healing Selectors:** Instead of just explaining the failure, I would engineer the framework to have the AI suggest a new, robust DOM locator on the fly and automatically retry the test execution to see if it passes.

**Visual Bug Detection:** I would integrate a Vision-capable model. By passing a screenshot of the failure alongside the DOM state, the AI could detect UI overlaps or rendering issues that HTML alone won't clearly reveal.

**CI/CD Integration & Automated Jira Ticketing:** I would wire this into a GitHub Actions pipeline. If the AI determines a failure is a genuine application bug (and not an automation script issue), the framework would automatically draft and post a structured bug ticket to Jira via its REST API, complete with steps to reproduce and the AI's root cause analysis.
