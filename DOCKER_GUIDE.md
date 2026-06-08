# 🍠 Potato Disease Detection - Cross-Platform Deployment Guide

This guide helps you run the Potato Disease Detection app on any device (Windows, Mac, Linux, cloud platforms).

## 📋 Prerequisites

### Required
- **Docker Desktop** - Download from https://www.docker.com/products/docker-desktop
  - Available for Windows, Mac, and Linux

### Optional (for local development without Docker)
- Python 3.11+
- Node.js 16+
- npm/yarn

## 🚀 Quick Start with Docker (Recommended)

### Windows Users

1. **Install Docker Desktop**
   - Download: https://www.docker.com/products/docker-desktop
   - Run the installer and restart your computer

2. **Run the setup script**
   ```
   setup.bat
   ```
   Or manually:
   ```bash
   docker-compose build
   docker-compose up -d
   ```

3. **Access the app**
   - Web Interface: http://localhost:3000
   - API: http://localhost:8000
   - API Documentation: http://localhost:8000/docs

### Mac/Linux Users

1. **Install Docker Desktop**
   - Download: https://www.docker.com/products/docker-desktop

2. **Run the setup script**
   ```bash
   chmod +x setup.sh
   ./setup.sh
   ```
   Or manually:
   ```bash
   docker-compose build
   docker-compose up -d
   ```

3. **Access the app**
   - Web Interface: http://localhost:3000
   - API: http://localhost:8000
   - API Documentation: http://localhost:8000/docs

## 📱 Access from Other Devices

### On the Same Network

1. Find your computer's IP address:
   - **Windows**: `ipconfig` → look for "IPv4 Address"
   - **Mac/Linux**: `ifconfig` or `hostname -I`

2. Access from another device:
   ```
   http://<your-computer-ip>:3000
   ```

3. For mobile apps in development, update the API URL in the frontend environment.

## 🛑 Stop the Application

```bash
docker-compose down
```

## 📊 Useful Docker Commands

```bash
# View logs
docker-compose logs -f

# Show running containers
docker-compose ps

# Restart services
docker-compose restart

# Rebuild images
docker-compose build --no-cache

# Remove containers and volumes
docker-compose down -v
```

## 🌐 Deployment to Cloud Platforms

### Free Options

#### 1. **Railway.app** (Backend + Database)
```bash
# Install Railway CLI
npm i -g @railway/cli

# Login and deploy
railway login
railway init
railway up
```

#### 2. **Vercel** (Frontend)
```bash
# Install Vercel CLI
npm i -g vercel

# Deploy
cd potato_disease/frontend
vercel
```

#### 3. **Render.com** (Full Stack)
- Connect your GitHub repository
- Select the `docker-compose.yml`
- Deploy

#### 4. **Fly.io**
```bash
# Install Flyctl
# https://fly.io/docs/hands-on/install-flyctl/

fly launch
fly deploy
```

### Paid Options (with free credits)
- **Azure** - $200 free credits
- **AWS** - 12 months free tier
- **Google Cloud** - $300 free credits

## 🔧 Environment Variables

Edit `.env.local` to customize:

```env
# Backend
ALLOWED_ORIGINS=http://localhost:3000,http://localhost

# Frontend
REACT_APP_API_URL=http://localhost:8000/predict

# Model
MODEL_PATH=/app/saved_models/2/potato_disease_detection.keras
```

## 📦 Project Structure

```
potato_disease/
├── api/                           # Backend (FastAPI)
│   ├── main.py                   # FastAPI application
│   ├── requirements.txt          # Python dependencies
│   └── venv312/                  # Virtual environment
├── frontend/                      # Frontend (React)
│   ├── public/
│   ├── src/
│   ├── package.json
│   └── README.md
├── saved_models/                  # Pre-trained models
│   ├── 1/
│   └── 2/
├── training/                      # Jupyter notebooks
├── PlantVillage/                  # Training dataset
├── Dockerfile.backend             # Backend container config
├── Dockerfile.frontend            # Frontend container config
├── docker-compose.yml             # Orchestration
├── nginx.conf                     # Nginx config
└── README.md                      # This file
```

## 🐛 Troubleshooting

### Port Already in Use
```bash
# Change ports in docker-compose.yml
# Or kill the process using the port

# Windows
netstat -ano | findstr :3000
taskkill /PID <PID> /F

# Mac/Linux
lsof -i :3000
kill -9 <PID>
```

### Model Not Found
- Ensure `saved_models/2/potato_disease_detection.keras` exists
- Check Docker volume mounts in `docker-compose.yml`

### API Connection Failed
- Check if backend is running: `docker-compose ps`
- View logs: `docker-compose logs backend`
- Verify `REACT_APP_API_URL` is correct

### Docker Build Fails
```bash
# Clear Docker cache and rebuild
docker-compose build --no-cache
```

## 📚 Additional Resources

- [Docker Documentation](https://docs.docker.com/)
- [FastAPI Deployment](https://fastapi.tiangolo.com/deployment/)
- [React Deployment](https://create-react-app.dev/deployment/)
- [TensorFlow Serving](https://www.tensorflow.org/tfx/serving/)

## 📞 Support

For issues or questions:
1. Check Docker logs: `docker-compose logs`
2. Verify all files are in place
3. Ensure Docker daemon is running
4. Try rebuilding: `docker-compose build --no-cache`

---

**🎉 Your app is now ready to run on any device with Docker!**
