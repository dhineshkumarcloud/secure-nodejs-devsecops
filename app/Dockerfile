# Base Image
FROM node:20-alpine

# Working Directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm ci --omit=dev

# Copy source code
COPY . .

# Expose application port
EXPOSE 8080

# Start application
CMD ["npm","start"]