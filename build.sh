#!/bin/bash

# Create temporary build directory
BUILD_DIR="/tmp/backend-app-build"
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"

# Copy necessary files
cp package.json "$BUILD_DIR/"
cp app.js "$BUILD_DIR/"

# Create Dockerfile in temp directory
cat > "$BUILD_DIR/Dockerfile" << 'EOF'
# Use Node.js
FROM node:alpine

# Set working directory
WORKDIR /app

# Copy package files first for better caching
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy application files
COPY app.js ./

# Expose port
EXPOSE 3000

# Start the application
CMD ["node", "app.js"]
EOF

# Build Docker image from temp directory
echo "Building Docker image from temporary directory..."
cd "$BUILD_DIR"
docker build -t my-backend-app .

# Clean up
cd -
rm -rf "$BUILD_DIR"

echo "Build complete! Image: my-backend-app"
