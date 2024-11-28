# Use official Python image as the base
FROM 3.11.10-alpine3.19

# Set working directory
WORKDIR /app

# Copy requirements file and install dependencies
COPY src/my_discord_bot /app
RUN pip install --no-cache-dir -r requirements.txt


# Expose the port for the HTTP server
EXPOSE 8080 

# Start both the HTTP server and Discord bot
CMD ["sh", "-c", "python /app/http_server.py & python /app/discord_bot.py"]