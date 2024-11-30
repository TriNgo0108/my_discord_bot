import discord
from discord.ext import commands
import openai
import os
import asyncio
import schedule
from dotenv import load_dotenv
from threading import Thread
import time

load_dotenv()

print(f"openai version {openai.__version__} ", flush=True)
openai.api_key = os.getenv("OPENAI_API_KEY")

intents = discord.Intents.default()
intents.guilds = True
intents.members = True

bot = commands.Bot(command_prefix="!", intents=intents)

async def get_chat_completion():
    try:
        response = openai.chat.completions.create(
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
        response_dict = response.model_dump()   
        response_message = response_dict["choices"][0]["message"]["content"]
        return response_message
    except Exception as e:
        print(f"❌ Error generating chat completion: {e}", flush=True)
        return None

async def send_daily_messages():
    guild_id = int(os.getenv("GUILD_ID"))
    guild = bot.get_guild(guild_id)

    if not guild:
        print("❌ Guild not found!", flush=True)
        return

    try:
        member_ids = [member.id for member in guild.members if not member.bot]

        chat_message = await get_chat_completion()
        if chat_message:
            for member_id in member_ids:
                try:
                    user = await bot.fetch_user(member_id)
                    if user:
                        await user.send(chat_message)
                        print(f"✅ Sent daily greeting to {user.name}", flush=True)
                except Exception as e:
                    print(f"❌ Failed to send message to {member_id}: {e}", flush=True)
    except Exception as e:
        print(f"❌ Error fetching members or sending messages: {e}", flush=True)

def run_scheduler():
    # Running this in a separate thread
    while True:
        schedule.run_pending()
        time.sleep(60)

def start_schedule(loop):

    schedule.every().day.at('07:00', "Asia/Ho_Chi_Minh").do(lambda: asyncio.run_coroutine_threadsafe(send_daily_messages(), loop))

    Thread(target=run_scheduler, daemon=True).start()

@bot.event
async def on_ready():
    print(f"🤖 Logged in as {bot.user}!", flush=True)
    start_schedule(bot.loop)

@bot.event
async def on_message(message):
    if message.author.bot:
        return

    if "hello" in message.content.lower():
        await message.reply("Hello! How can I assist you today? 🤖")

if __name__ == "__main__":
    bot.run(os.getenv("DISCORD_TOKEN"))