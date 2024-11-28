import discord
from discord.ext import commands
import openai
import os
import asyncio
import schedule
import time
from threading import Thread
from dotenv import load_dotenv
import pytz

load_dotenv()

# OpenAI API Setup
openai.api_key = os.getenv("OPENAI_API_KEY")

# Discord Bot Setup
intents = discord.Intents.default()
intents.guilds = True
intents.members = True

bot = commands.Bot(command_prefix="!", intents=intents)

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

def run_scheduler():
    # Running this in a separate thread
    while True:
        # This runs pending scheduled jobs
        schedule.run_pending()
        time.sleep(60)  # Check every minute

def start_schedule():
    # Use pytz to define timezone (Asia/Ho_Chi_Minh for Vietnam)
    vietnam_tz = pytz.timezone('Asia/Ho_Chi_Minh')

    def schedule_task():
        loop = asyncio.get_event_loop()
        asyncio.run_coroutine_threadsafe(send_daily_messages(), loop)

    # Schedule to run at 7:00 AM VNT
    schedule.every().day.at("07:00").do(schedule_task)

    # Start scheduler in a new thread
    Thread(target=run_scheduler, daemon=True).start()

@bot.event
async def on_ready():
    print(f"🤖 Logged in as {bot.user}!")
    start_schedule()  # Start the scheduling when the bot is ready

@bot.event
async def on_message(message):
    if message.author.bot:
        return

    if "hello" in message.content.lower():
        await message.reply("Hello! How can I assist you today? 🤖")

if __name__ == "__main__":
    bot.run(os.getenv("DISCORD_TOKEN"))