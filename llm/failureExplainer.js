import axios from "axios";
import dotenv from "dotenv";

dotenv.config();

const API_KEY = process.env.OPENROUTER_API_KEY;

export async function explainFailure(errorDetails) {
  try {
    const response = await axios.post(
      "https://openrouter.ai/api/v1/chat/completions",
      {
        model: "mistralai/mistral-7b-instruct",  // safe free model
        messages: [
          {
            role: "system",
            content: "You are a QA automation assistant. Explain test failures clearly and suggest fixes."
          },
          {
            role: "user",
            content: `Here is a failed test:\n\n${errorDetails}`
          }
        ]
      },
      {
        headers: {
          Authorization: `Bearer ${API_KEY}`,
          "Content-Type": "application/json"
        }
      }
    );

    return response.data.choices[0].message.content;

  } catch (err) {
    return "OpenRouter error: " + err.message;
  }
}
