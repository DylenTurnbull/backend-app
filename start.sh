#!/bin/bash

# Script to start the backend application using standalone Docker containers

echo "Starting backend application..."

# Build the backend image
echo "Building backend image..."
./build.sh

# Create network if it doesn't exist
docker network create backend-network 2>/dev/null || echo "Network backend-network already exists"

# Stop and remove existing containers if they exist
docker stop my-backend my-nginx 2>/dev/null || true
docker rm my-backend my-nginx 2>/dev/null || true

# Start backend container
echo "Starting backend container..."
docker run -d --name my-backend --network backend-network my-backend-app

# Start nginx container with port 80 and volume mounts
echo "Starting nginx container..."
docker run -d \
  --name my-nginx \
  --network backend-network \
  -p 80:80 \
  -v "$(pwd)/nginx.conf:/etc/nginx/nginx.conf:ro" \
  -v "$(pwd)/index.html:/usr/share/nginx/html/index.html:ro" \
  nginx:alpine

echo "Application started successfully!"
echo "Frontend available at: http://localhost"
echo "Backend API available at: http://localhost/api"
echo ""
echo "To stop the application, run: ./stop.sh"
