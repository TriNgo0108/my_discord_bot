import { Client, GatewayIntentBits } from "discord.js";
import schedule from "node-schedule";
import dotenv from "dotenv";

dotenv.config();

const client = new Client({
  intents: [
    GatewayIntentBits.Guilds, // To join and interact in servers
    GatewayIntentBits.DirectMessages,
    GatewayIntentBits.GuildMembers, // To send messages directly to users
  ],
  partials: ["CHANNEL"], // To handle direct messages
});

client.once("ready", async () => {
  console.log(`🤖 Logged in as ${client.user.tag}!`);
  const guildId = process.env.GUILD_ID;
  const guild = client.guilds.cache.get(guildId);
  const members = await guild.members.fetch();
  const memberIds = members
    .filter((member) => !member.user.bot)
    .map((member) => member.id);
  schedule.scheduleJob("0 7 * * *", async () => {
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
});

client.on("messageCreate", (message) => {
  if (message.author.bot) return;

  // Respond to a greeting
  if (message.content.toLowerCase().includes("hello")) {
    message.reply("Hello! How can I assist you today? 🤖");
  }
});

// Login to Discord with your bot token
client.login(process.env.DISCORD_TOKEN);
