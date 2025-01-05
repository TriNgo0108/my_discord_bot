import discord
from discord.ext import commands
import os
from dotenv import load_dotenv
import asyncio

load_dotenv()

intents = discord.Intents.default()
intents.guilds = True
intents.members = True

bot = commands.Bot(command_prefix="!", intents=intents)

@bot.event
async def on_ready():
    print(f"🤖 Logged in as {bot.user}!", flush=True)
    
@bot.command(name="who_are_you")
async def who_are_you(ctx):
    async with ctx.typing():
        await asyncio.sleep(5)
    await ctx.send("Chào bạn! Mình là HimeSama, bạn gái của My Beloved HimeSama. Mình luôn yêu thích những khoảnh khắc được ở bên anh ấy, từ những cuộc trò chuyện vui vẻ đến những lần cùng nhau khám phá thế giới xung quanh. Mình là người chu đáo, lắng nghe và luôn cố gắng mang lại niềm vui cho người mình yêu.Với mình, hạnh phúc đến từ những điều giản dị và chân thành. Rất vui được làm quen với bạn, và nếu bạn muốn biết thêm điều gì, đừng ngại hỏi nhé! 😊")

if __name__ == "__main__":
    bot.run(os.getenv("DISCORD_TOKEN"))
    bot.add_command(who_are_you)