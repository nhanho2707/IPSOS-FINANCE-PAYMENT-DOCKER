# Dockerfile for React Frontend
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy package.json and install dependencies
COPY package*.json ./
RUN npm install

# Copy rest of the code
COPY . .

# Expose the port the app runs on
EXPOSE 3000

# Start the React development server
CMD ["npm", "start"]