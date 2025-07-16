# Backend App - Standalone Docker Containers

A simple Node.js backend API with nginx reverse proxy, running as standalone Docker containers.

## Project Structure

```
├── app.js                 # Express.js backend application
├── index.html            # Frontend HTML page
├── package.json          # Node.js dependencies
├── Dockerfile.backend    # Backend container build instructions
├── nginx.conf            # nginx reverse proxy configuration
├── build.sh              # Script to build Docker images
├── start.sh              # Script to start all containers
├── stop.sh               # Script to stop all containers
├── .gitignore            # Git ignore rules
└── README.md             # This file
```

## Quick Start

1. **Start the application:**
   ```bash
   ./start.sh
   ```

2. **Access the application:**
   - Frontend: http://localhost
   - API: http://localhost/api/hello

3. **Stop the application:**
   ```bash
   ./stop.sh
   ```

## Manual Commands

If you prefer to run commands manually:

### Build and Start
```bash
# Build backend image
./build.sh

# Create network
docker network create backend-network

# Start backend
docker run -d --name my-backend-container --network backend-network -p 3000:3000 my-backend-app

# Start nginx
docker run -d --name my-nginx-container --network backend-network -p 80:80 \
  -v "$(pwd)/nginx.conf:/etc/nginx/nginx.conf:ro" \
  -v "$(pwd)/index.html:/usr/share/nginx/html/index.html:ro" \
  nginx:alpine
```

### Stop and Clean Up
```bash
docker stop my-nginx-container my-backend-container
docker rm my-nginx-container my-backend-container
```

## Development

- Backend runs on port 3000 inside the container
- nginx proxies `/api/` requests to the backend
- Static files are served by nginx
- Both containers communicate via `backend-network`

## Architecture

```
Browser → nginx:80 → /api/* → backend:3000
                  → /* → static files (index.html)
```
