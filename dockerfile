# Use official Python image as the base
FROM python:3.11.10-alpine3.19

# Set working directory
WORKDIR /app

# Copy requirements file and install dependencies
COPY src/discord_bot /app
RUN pip install --no-cache-dir -r requirements.txt


# Expose the port for the HTTP server
EXPOSE 8080 

# Start both the HTTP server and Discord bot
CMD ["sh", "-c", "python /app/my_http_server.py & python /app/discord_bot.py"]