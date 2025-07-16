#!/bin/bash

# Script to stop the backend application containers

echo "Stopping backend application..."

# Stop containers
docker stop my-nginx my-backend 2>/dev/null || echo "Some containers were already stopped"

# Remove containers
docker rm my-nginx my-backend 2>/dev/null || echo "Some containers were already removed"

echo "Application stopped successfully!"
