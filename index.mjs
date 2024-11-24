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

  await client.login(process.env.DISCORD_TOKEN);

  const openAiClient = new OpenAI({
    apiKey: process.env.OPENAI_API_KEY, // This is the default and can be omitted
  });


  
  const chatCompletion = await openAiClient.chat.completions.create({
    messages: [{ role: 'user', content: 'Please act as my wife and send me a sweet, lovely good morning greeting. Also, let me know the weather in Can Tho today, and make sure to say it in Vietnamese' }],
    model: 'gpt-4o',
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
              await member.send("Good morning! 🌞 Wake up and do some exercise");
              console.log(`✅ Sent daily greeting to ${member.tag}`);
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
  

  return context.logStreamName;
};
