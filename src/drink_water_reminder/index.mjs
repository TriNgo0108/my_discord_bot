import { Client, GatewayIntentBits } from "discord.js";
import dotenv from "dotenv";
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

const prompt = "Please act as my wife and send me a warm and loving reminder in Vietnamese to drink water and keep the tone gentle, caring. Avoid including any extra notes or signature. The message should be simple as possible";

const result = await model.generateContent(prompt);
  
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
              await member.send(result.response.text());
              console.log(`Sent drink water message to ${member.tag}`);
            }
          }
      } catch (error) {
        console.error("Failed to send drink water message:", error);
      }
  
  });
  
  await client.login(process.env.DISCORD_TOKEN);
  await new Promise((resolve) => setTimeout(() => resolve(), 10000))
  return context.logStreamName;
};