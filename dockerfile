# Base image
FROM node:20

# Set the working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install --production

# Copy the rest of the code
COPY . .

# Expose the port (if applicable)
EXPOSE 3000

# Define environment variables (optional, can be overridden by Render)
ENV NODE_ENV=production

# Start the bot
CMD ["node", "index.js"]
