import discord
from discord.ext import commands
import os
from dotenv import load_dotenv

load_dotenv()

intents = discord.Intents.default()
intents.guilds = True
intents.members = True

bot = commands.Bot(command_prefix="!", intents=intents)

@bot.event
async def on_ready():
    print(f"🤖 Logged in as {bot.user}!", flush=True)

@bot.event
async def on_message(message):
    if message.author.bot:
        return

    if "hello" in message.content.lower():
        await message.reply("Hello! How can I assist you today? 🤖")

if __name__ == "__main__":
    bot.run(os.getenv("DISCORD_TOKEN"))