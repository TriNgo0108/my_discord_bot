import { Client, GatewayIntentBits } from "discord.js";
import dotenv from "dotenv";
import { GoogleGenerativeAI } from "@google/generative-ai";
export const handler = async (event, context) =>{
  if(!process.env.environment) {
    dotenv.config();  
  }
  const client = new Client({
    intents: [
      GatewayIntentBits.Guilds, 
      GatewayIntentBits.DirectMessages,
      GatewayIntentBits.GuildMembers,
    ],
    partials: ["CHANNEL"], 
  });

  
  const genAI = new GoogleGenerativeAI(process.env.GOOGLE_GEMINI_KEY);
  const model = genAI.getGenerativeModel({ model: "gemini-1.5-flash" });
  
  const prompt = "Please act as my wife and send me a sweet and loving good morning message in Vietnamese. Also, kindly include the weather forecast for Can Tho today. and add some cute icons. Please keep it warm and loving, and do not add any extra notes, signature.";
  
  const result = await model.generateContent(prompt);

  client.once("ready", async () => {
    console.log(`Logged in as ${client.user.tag}!`);
    const guildId = process.env.GUILD_ID;
    const guild = client.guilds.cache.get(guildId);
    const members = await guild.members.fetch();
    const memberIds = members
      .filter((member) => !member.user.bot)
      .map((member) => member.id);
    try {
          for (let memberId of memberIds) {
            const member = await client.users.fetch(memberId);
            if (member) {
              await member.send(result.response.text());
              console.log(`Sent daily greeting to ${member.tag}`);
            }
          }
      } catch (error) {
        console.error("Failed to send daily message:", error);
      }
  
  });
  
  await client.login(process.env.DISCORD_TOKEN);
  await new Promise((resolve) => setTimeout(() => resolve(), 10000))
  return context.logStreamName;
};