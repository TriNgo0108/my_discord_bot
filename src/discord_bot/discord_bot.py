import discord
from discord.ext import commands
import openai
import os
import asyncio
import schedule
import time
from threading import Thread
from dotenv import load_dotenv

load_dotenv()
# OpenAI API Setup
openai.api_key = os.getenv("OPENAI_API_KEY")

async def get_chat_completion():
    try:
        response = openai.ChatCompletion.create(
            model="gpt-4",
            messages=[
                {
                    "role": "user",
                    "content": (
                        "Please act as my wife and send me a sweet and loving good morning message "
                        "in Vietnamese. Also, kindly include the weather forecast for Can Tho today "
                        "and add some cute icons. Please keep it warm and loving, and do not add "
                        "any extra notes, signature."
                    ),
                }
            ],
        )
        return response["choices"][0]["message"]["content"]
    except Exception as e:
        print(f"❌ Error generating chat completion: {e}")
        return None

# Discord Bot Setup
intents = discord.Intents.default()
intents.guilds = True
intents.direct_messages = True
intents.members = True
intents.messages = True
intents.message_content = True

bot = commands.Bot(command_prefix="!", intents=intents)

async def send_daily_messages():
    guild_id = int(os.getenv("GUILD_ID"))
    guild = bot.get_guild(guild_id)

    if not guild:
        print("❌ Guild not found!")
        return

    try:
        members = await guild.fetch_members().flatten()
        member_ids = [member.id for member in members if not member.bot]

        chat_message = await get_chat_completion()
        if chat_message:
            for member_id in member_ids:
                try:
                    user = await bot.fetch_user(member_id)
                    if user:
                        await user.send(chat_message)
                        print(f"✅ Sent daily greeting to {user.name}")
                except Exception as e:
                    print(f"❌ Failed to send message to {member_id}: {e}")
    except Exception as e:
        print(f"❌ Error fetching members or sending messages: {e}")

def schedule_tasks():
    async def run_daily_messages():
        await send_daily_messages()

    # Schedule daily messages at 9:00 AM
    schedule.every().day.at("07:00").do(lambda: asyncio.run(run_daily_messages()))

    while True:
        schedule.run_pending()
        time.sleep(1)

# Start Scheduler in a Separate Thread
scheduler_thread = Thread(target=schedule_tasks, daemon=True)
scheduler_thread.start()

@bot.event
async def on_ready():
    print(f"🤖 Logged in as {bot.user}!")

@bot.event
async def on_message(message):
    if message.author.bot:
        return

    if "hello" in message.content.lower():
        await message.reply("Hello! How can I assist you today? 🤖")

if __name__ == "__main__":
    bot.run(os.getenv("DISCORD_TOKEN"))
