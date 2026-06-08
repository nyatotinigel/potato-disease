#!/bin/bash
# Docker setup script for Linux/Mac

echo "🍠 Potato Disease Detection - Docker Setup"
echo "==========================================="
echo ""

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed. Please install Docker Desktop first:"
    echo "   https://www.docker.com/products/docker-desktop"
    exit 1
fi

echo "✓ Docker found"

# Check if Docker Compose is installed
if ! command -v docker-compose &> /dev/null; then
    echo "❌ Docker Compose is not installed."
    exit 1
fi

echo "✓ Docker Compose found"
echo ""

# Build images
echo "📦 Building Docker images..."
docker-compose build

echo ""
echo "✓ Images built successfully!"
echo ""
echo "📱 Starting services..."
docker-compose up -d

echo ""
echo "✓ Services started!"
echo ""
echo "🌐 Access the app at: http://localhost:3000"
echo "🔧 API is running at: http://localhost:8000"
echo "📊 API docs at: http://localhost:8000/docs"
echo ""
echo "💡 Useful commands:"
echo "   docker-compose logs -f        (view logs)"
echo "   docker-compose down           (stop services)"
echo "   docker-compose ps             (show running containers)"
echo ""
