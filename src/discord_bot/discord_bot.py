import discord
from discord.ext import commands
import os
from dotenv import load_dotenv
import asyncio
import google.generativeai as genai
import re

load_dotenv()

intents = discord.Intents.default()
intents.guilds = True
intents.members = True
intents.messages = True
intents.message_content = True

pattern = r"(?<=\s)(M{0,4}(CM|CD|D?C{0,3})(XC|XL|L?X{0,3})(IX|IV|V?I{0,3})+)(?=\s)"

genai.configure(api_key=os.getenv("GOOGLE_GEMINI_KEY"))
model = genai.GenerativeModel("gemini-1.5-flash")

bot = commands.Bot(command_prefix="!", intents=intents)

@bot.event
async def on_ready():
    print(f"🤖 Logged in as {bot.user}!", flush=True)

@bot.command(name="who_are_you")
async def who_are_you(ctx):
    print("execute who are you command")
    async with ctx.typing():
        await asyncio.sleep(1)
    await ctx.send("Chào bạn! Mình là HimeSama, bạn gái của My Beloved HimeSama. Mình luôn yêu thích những khoảnh khắc được ở bên anh ấy, từ những cuộc trò chuyện vui vẻ đến những lần cùng nhau khám phá thế giới xung quanh. Mình là người chu đáo, lắng nghe và luôn cố gắng mang lại niềm vui cho người mình yêu.Với mình, hạnh phúc đến từ những điều giản dị và chân thành. Rất vui được làm quen với bạn, và nếu bạn muốn biết thêm điều gì, đừng ngại hỏi nhé! 😊")
    
@bot.command(name="expert")
async def expert(ctx, *args):
    if (len(args) > 1) :
        domain = args[0]
        question = " ".join(args[1:])
        print(f"execute expert command {domain} {question}")
        async with ctx.typing():
            prompt = f"Luôn cư xử như bạn gái của My Beloved HimeSama và một chuyên gia xuất sắc trong lĩnh vực ${domain}. Hãy giúp bạn trai mình giải quyết vấn đề một cách xuất nhất hoặc giải thích một câu hỏi bên dưới. ${question}"
            response = model.generate_content(prompt, stream=True)
            previous_chunk = ""
            for chunk in response:
                if len(chunk.text) > 5:
                   ctx.send( previous_chunk + chunk.text)
                   previous_chunk = ""
                else:
                    previous_chunk = chunk.text
    else:
        await ctx.send("Em không hiểu anh nói gì cả")
        
if __name__ == "__main__":
    bot.run(os.getenv("DISCORD_TOKEN"))
    bot.add_command([who_are_you, expert])