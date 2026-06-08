@echo off
REM Docker setup script for Windows

echo.
echo Potato Disease Detection - Docker Setup
echo ===========================================
echo.

REM Check if Docker is installed
docker --version >nul 2>&1
if errorlevel 1 (
    echo [X] Docker is not installed or not in PATH.
    echo Please install Docker Desktop first: https://www.docker.com/products/docker-desktop
    pause
    exit /b 1
)

echo [OK] Docker found
echo.

REM Check if Docker Compose is installed
docker-compose --version >nul 2>&1
if errorlevel 1 (
    docker compose version >nul 2>&1
    if errorlevel 1 (
        echo [X] Docker Compose is not installed.
        pause
        exit /b 1
    )
)

echo [OK] Docker Compose found
echo.

REM Build images
echo Building Docker images...
docker-compose build

if errorlevel 1 (
    echo [X] Build failed!
    pause
    exit /b 1
)

echo.
echo [OK] Images built successfully!
echo.

REM Start containers
echo Starting services...
docker-compose up -d

if errorlevel 1 (
    echo [X] Failed to start services!
    pause
    exit /b 1
)

echo.
echo [OK] Services started!
echo.
echo Web app: http://localhost:3000
echo API: http://localhost:8000
echo API docs: http://localhost:8000/docs
echo.
echo Useful commands:
echo   docker-compose logs -f      ^(view logs^)
echo   docker-compose down         ^(stop services^)
echo   docker-compose ps           ^(show containers^)
echo.
pause
