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
    apiKey: process.env.OPENAI_API_KEY, // This is the default and can be omitted
  });
  
  const chatCompletion = await openAiClient.chat.completions.create({
    messages: [{ role: 'user', content: 'Please act as my wife and send me a warm and loving reminder in Vietnamese to drink water. Include some health tips for today, add cute and playful icons to make it cheerful, and keep the tone gentle and caring. Avoid including any extra notes or signature.' }],
    model: 'gpt-4',
  });
  
  client.once("ready", async () => {
    console.log(`🤖 Logged in as ${client.user.tag}!`);
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
              console.log(`✅ Sent daily drink water to ${member.tag}`);
            }
          }
      } catch (error) {
        console.error("❌ Failed to send daily message:", error);
      }
  
  });
  
  client.on("messageCreate", (message) => {
    if (message.author.bot) return;
  
    // Respond to a greeting
    if (message.content.toLowerCase().includes("hello")) {
      message.reply("Hello! How can I assist you today? 🤖");
    }
  });
  await client.login(process.env.DISCORD_TOKEN);
  await new Promise((resolve) => setTimeout(() => resolve(), 10000))
  return context.logStreamName;
};