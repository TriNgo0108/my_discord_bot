import { Client, GatewayIntentBits } from "discord.js";
import dotenv from "dotenv";
import OpenAI from 'openai';
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
  const openAiClient = new OpenAI({
    apiKey: process.env.OPENAI_API_KEY, 
  });
  
  const chatCompletion = await openAiClient.chat.completions.create({
    messages: [{ role: 'user', content: 'Please act as my wife and send me a sweet and loving good morning message in Vietnamese. Also, kindly include the weather forecast for Can Tho today and add some cute icons. Please keep it warm and loving, and do not add any extra notes, signature.' }],
    model: 'gpt-4',
  });
  
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
              await member.send(chatCompletion.choices[0].message.content);
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