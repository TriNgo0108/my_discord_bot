import discord
from discord.ext import commands
import os
from dotenv import load_dotenv
import asyncio
import google.generativeai as genai

load_dotenv()

intents = discord.Intents.default()
intents.guilds = True
intents.members = True
intents.messages = True
intents.message_content = True

genai.configure(api_key=os.getenv("GOOGLE_GEMINI_KEY"))
model = genai.GenerativeModel("gemini-1.5-flash")

bot = commands.Bot(command_prefix="!", intents=intents)

@bot.event
async def on_ready():
    print(f"🤖 Logged in as {bot.user}!", flush=True)
    
    
def split_text(text, limit_chars=2000):
    """
    Splits a long text into smaller parts with a character limit per part,
    also splitting at newline characters. Removes parts with only whitespace.

    Args:
        text: The text to be split.
        limit_chars: The maximum number of characters per part (default is 2000).

    Returns:
        A list of strings, each string is a part of the original text,
        with whitespace-only parts removed.
    """

    parts = []
    start = 0
    while start < len(text):
        end = start + limit_chars
        if end >= len(text):
            part = text[start:]
            if part.strip():  # Check if part is not just whitespace
                parts.append(part)
            break
        
        # Find the next newline before or at the end limit
        next_newline = text.find('\n', start, end)
        if next_newline != -1:
            end = next_newline
        else:
            # Try to avoid cutting words if no newline is found
            while end > start and text[end] != ' ':
                end -= 1
            if end == start:
                end = start + limit_chars

        part = text[start:end+1] if next_newline != -1 else text[start:end]
        if part.strip():  # Check if part is not just whitespace
            parts.append(part)
        start = end + 1

    return parts



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
        print(f"execute expert command {domain} {question}",  flush=True)
        async with ctx.typing():
            prompt = f"Luôn cư xử như bạn gái của My Beloved HimeSama và một chuyên gia xuất sắc trong lĩnh vực ${domain}. Hãy giúp bạn trai mình giải quyết vấn đề một cách xuất nhất hoặc giải thích một câu hỏi bên dưới. ${question}"
            response = model.generate_content(prompt)
            split_responses = split_text(response.text)
            for part in split_responses:
                await ctx.send(part)
    else:
        await ctx.send("Em không hiểu anh nói gì cả")
        
@bot.command(name="touch_glass")
async def touch_glass(ctx):
    prompt = "Act as my beloved girlfriend. We're lying on a soft, woven blanket in a secluded meadow. Wildflowers of all colors sway gently in the warm breeze, their sweet fragrance mingling with the earthy scent of the grass beneath us. The sun filters through the leaves of the ancient oak trees bordering the meadow, casting dappled shadows on our faces. Small, colorful butterflies flutter nearby, drawn to the vibrancy of the blooms. Describe this scene in a single, evocative paragraph in Vietnamese, focusing on the sensory details and the feeling of peaceful intimacy we share. Let the description feel like a love letter."         
    async with ctx.typing():
        response = model.generate_content(prompt)
        await ctx.send(response.text)

        
if __name__ == "__main__":
    bot.run(os.getenv("DISCORD_TOKEN"))
    bot.add_command([who_are_you, expert, touch_glass])