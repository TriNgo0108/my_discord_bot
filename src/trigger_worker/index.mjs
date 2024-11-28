// import { Client, GatewayIntentBits } from "discord.js";
import dotenv from "dotenv";
// import OpenAI from 'openai';

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


let retryCounter = 0;
  const maxRetry = 4;
  const sleepTime = 1500;
  dotenv.config();

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
