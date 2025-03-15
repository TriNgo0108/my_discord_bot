import dotenv from "dotenv";

export const handler = async (event, context) => {
  let retryCounter = 0;
  const maxRetry = 4;
  const sleepTime = 1500;
  if (!process.env.environment) {
    dotenv.config();
  }

  let response = await fetch(process.env.RENDER_BACKEND_ENDPOINT);
  while (!response.ok && retryCounter <= maxRetry) {
    await new Promise((resolve) => setTimeout(resolve, sleepTime));
    retryCounter++;
    response = await fetch(process.env.RENDER_BACKEND_ENDPOINT);
  }

  if (response.ok) console.log("Trigger worker successfully");
  else {
    console.error("Failed to trigger worker");
  }

  return context.logStreamName;
};
