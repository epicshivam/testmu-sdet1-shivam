import { explainFailure } from '../../llm/failureExplainer.js';

export async function handleFailure(testInfo, error, page) {
  try {
    const pageText = await page.content();

    const failureDetails = `
Test Name: ${testInfo.title}
Error: ${error.message}
URL: ${page.url()}
`;

    const explanation = await explainFailure(failureDetails);

    await testInfo.attach('AI Failure Explanation', {
      body: explanation,
      contentType: 'text/plain',
    });

  } catch (aiError) {
    console.log("AI failure handling error:", aiError.message);
  }
}
