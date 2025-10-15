# Deployment Guide - Dix Oracle Core

This guide covers deployment strategies for Dix Oracle Core across different platforms.

## Prerequisites

- Git and GitHub account
- Docker (optional, for containerization)
- Cloud provider account (AWS, GCP, Azure, or DigitalOcean)
- Domain name (optional but recommended)
- SSL certificate (Let's Encrypt recommended)

## Deployment Options

### 1. Frontend (Web) Deployment

#### Option A: Static Hosting (Recommended)

**Platforms**: Vercel, Netlify, GitHub Pages, AWS S3 + CloudFront

**Steps for Vercel**:
```bash
# Install Vercel CLI
npm install -g vercel

# Build and deploy
cd web
npm run build
vercel --prod
```

**Steps for Netlify**:
```bash
# Install Netlify CLI
npm install -g netlify-cli

# Build and deploy
cd web
npm run build
netlify deploy --prod --dir=dist
```

**Configuration**:
- Build command: `npm run build`
- Output directory: `dist`
- Node version: 20.x

#### Option B: Docker Container

Create `web/Dockerfile`:
```dockerfile
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

Deploy:
```bash
docker build -t dixoraclecore-web ./web
docker run -p 80:80 dixoraclecore-web
```

### 2. API Server Deployment

#### Option A: Platform as a Service (Recommended)

**Platforms**: Heroku, Railway, Render

**Steps for Render**:
1. Connect GitHub repository
2. Create new Web Service
3. Configure:
   - Build Command: `cd api-server && npm install`
   - Start Command: `cd api-server && npm start`
   - Environment Variables (see below)

#### Option B: Docker Container

Create `api-server/Dockerfile`:
```dockerfile
FROM node:20-alpine
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY . .
EXPOSE 4000
CMD ["npm", "start"]
```

Deploy:
```bash
docker build -t dixoraclecore-api ./api-server
docker run -p 4000:4000 --env-file .env dixoraclecore-api
```

#### Option C: VPS (DigitalOcean, AWS EC2)

```bash
# On server
sudo apt update
sudo apt install nodejs npm

# Clone repo
git clone https://github.com/your-org/Vital-Frecuency.git
cd Vital-Frecuency/api-server

# Install dependencies
npm install --production

# Setup PM2 for process management
npm install -g pm2
pm2 start src/index.js --name dixoraclecore-api
pm2 startup
pm2 save
```

### 3. Core AI Engine Deployment

#### Option A: GPU-enabled Cloud Instance

**Platforms**: AWS EC2 (with GPU), Google Cloud Platform, Azure

**Setup**:
```bash
# On GPU instance
sudo apt update
sudo apt install python3 python3-pip python3-venv

# Clone and setup
git clone https://github.com/your-org/Vital-Frecuency.git
cd Vital-Frecuency/core-ai

# Create virtual environment
python3 -m venv venv
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt

# Install CUDA (for GPU support)
# Follow NVIDIA CUDA installation guide

# Run with gunicorn
pip install gunicorn
gunicorn -w 4 -k uvicorn.workers.UvicornWorker main:app --bind 0.0.0.0:8080
```

#### Option B: Docker with GPU Support

Create `core-ai/Dockerfile`:
```dockerfile
FROM pytorch/pytorch:2.0.0-cuda11.7-cudnn8-runtime

WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .
EXPOSE 8080

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080"]
```

Deploy:
```bash
docker build -t dixoraclecore-ai ./core-ai
docker run --gpus all -p 8080:8080 dixoraclecore-ai
```

### 4. Desktop App Distribution

#### Windows
```bash
cd desktop
npm install
npm install -g electron-builder

# Build for Windows
electron-builder --win
```

#### macOS
```bash
cd desktop
npm install
npm install -g electron-builder

# Build for macOS
electron-builder --mac
```

#### Linux
```bash
cd desktop
npm install
npm install -g electron-builder

# Build for Linux
electron-builder --linux
```

Distribute via:
- GitHub Releases
- Microsoft Store (Windows)
- Mac App Store (macOS)
- Snapcraft (Linux)

### 5. Android App Deployment

#### Google Play Store

1. **Prepare keystore**:
```bash
keytool -genkey -v -keystore release-key.keystore -alias my-key-alias -keyalg RSA -keysize 2048 -validity 10000
```

2. **Build release APK**:
```bash
cd android
./gradlew assembleRelease
```

3. **Sign APK**:
```bash
jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore release-key.keystore app/build/outputs/apk/release/app-release-unsigned.apk my-key-alias
```

4. **Optimize**:
```bash
zipalign -v 4 app-release-unsigned.apk app-release.apk
```

5. **Upload to Google Play Console**

## Environment Variables

### API Server (.env)
```env
# Server
NODE_ENV=production
PORT=4000

# Database
MONGO_URL=mongodb+srv://user:pass@cluster.mongodb.net/dbname

# Security
JWT_SECRET=your-secure-random-string-here
SESSION_SECRET=another-secure-random-string

# OAuth Providers
GOOGLE_CLIENT_ID=your-google-client-id
GOOGLE_CLIENT_SECRET=your-google-client-secret
STEAM_API_KEY=your-steam-api-key

# Monitoring
SENTRY_DSN=https://your-sentry-dsn@sentry.io/123456

# Frontend URL (for CORS)
FRONTEND_URL=https://your-domain.com
```

### Core AI (.env)
```env
MODEL_PATH=/models/yolov8n.pt
MAX_WORKERS=4
CUDA_VISIBLE_DEVICES=0
SENTRY_DSN=your-sentry-dsn
```

## Database Setup

### MongoDB Atlas (Recommended)

1. Create account at https://www.mongodb.com/cloud/atlas
2. Create a new cluster (free tier available)
3. Add database user
4. Whitelist IP addresses (0.0.0.0/0 for public access)
5. Get connection string
6. Update MONGO_URL in .env

### Self-hosted MongoDB

```bash
# Install MongoDB
sudo apt install mongodb

# Start service
sudo systemctl start mongodb
sudo systemctl enable mongodb

# Configure in .env
MONGO_URL=mongodb://localhost:27017/dixoraclecore
```

## SSL/TLS Configuration

### Using Let's Encrypt (Free)

```bash
# Install Certbot
sudo apt install certbot

# For Nginx
sudo certbot --nginx -d your-domain.com -d www.your-domain.com

# For standalone (if not using web server)
sudo certbot certonly --standalone -d your-domain.com
```

### Nginx Configuration

```nginx
server {
    listen 80;
    server_name your-domain.com;
    return 301 https://$server_name$request_uri;
}

server {
    listen 443 ssl http2;
    server_name your-domain.com;

    ssl_certificate /etc/letsencrypt/live/your-domain.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/your-domain.com/privkey.pem;

    # Frontend
    location / {
        root /var/www/dixoraclecore/web/dist;
        try_files $uri $uri/ /index.html;
    }

    # API
    location /api {
        proxy_pass http://localhost:4000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }

    # AI Engine
    location /ai {
        proxy_pass http://localhost:8080;
        proxy_http_version 1.1;
        proxy_set_header Host $host;
    }
}
```

## Docker Compose Setup

Create `docker-compose.yml` at root:

```yaml
version: '3.8'

services:
  web:
    build: ./web
    ports:
      - "80:80"
    depends_on:
      - api
    restart: unless-stopped

  api:
    build: ./api-server
    ports:
      - "4000:4000"
    environment:
      - NODE_ENV=production
      - MONGO_URL=${MONGO_URL}
      - JWT_SECRET=${JWT_SECRET}
    depends_on:
      - mongodb
    restart: unless-stopped

  ai:
    build: ./core-ai
    ports:
      - "8080:8080"
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              count: 1
              capabilities: [gpu]
    restart: unless-stopped

  mongodb:
    image: mongo:7
    ports:
      - "27017:27017"
    volumes:
      - mongodb_data:/data/db
    restart: unless-stopped

volumes:
  mongodb_data:
```

Deploy:
```bash
docker-compose up -d
```

## CI/CD Pipeline

### GitHub Actions

Create `.github/workflows/deploy.yml`:

```yaml
name: Deploy

on:
  push:
    branches: [main]

jobs:
  deploy-web:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: '20'
      - name: Build web
        run: |
          cd web
          npm ci
          npm run build
      - name: Deploy to Vercel
        uses: amondnet/vercel-action@v25
        with:
          vercel-token: ${{ secrets.VERCEL_TOKEN }}
          vercel-org-id: ${{ secrets.VERCEL_ORG_ID }}
          vercel-project-id: ${{ secrets.VERCEL_PROJECT_ID }}

  deploy-api:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Deploy to Render
        run: |
          curl -X POST ${{ secrets.RENDER_DEPLOY_HOOK }}
```

## Monitoring & Maintenance

### Health Checks

```bash
# API health
curl https://api.your-domain.com/api/ping

# AI health
curl https://api.your-domain.com/ai/health
```

### Logs

```bash
# PM2 logs
pm2 logs dixoraclecore-api

# Docker logs
docker logs container-name

# System logs
journalctl -u nginx
```

### Backups

```bash
# MongoDB backup
mongodump --uri="mongodb://user:pass@host:27017/dbname" --out=/backup/$(date +%Y%m%d)

# Automate with cron
0 2 * * * /usr/local/bin/backup-mongodb.sh
```

## Performance Optimization

1. **Enable gzip compression** (Nginx/CDN)
2. **Use CDN** for static assets
3. **Enable caching** headers
4. **Optimize images** before deployment
5. **Minify** JavaScript/CSS
6. **Use connection pooling** for database
7. **Implement rate limiting**
8. **Use load balancer** for high traffic

## Security Checklist

- [ ] HTTPS enabled everywhere
- [ ] Environment variables secured
- [ ] Database access restricted
- [ ] Rate limiting configured
- [ ] CORS properly configured
- [ ] Security headers set (Helmet.js)
- [ ] Regular security updates
- [ ] Secrets not in code
- [ ] Monitoring and alerts active
- [ ] Backups configured

## Rollback Strategy

```bash
# Using PM2
pm2 list
pm2 stop dixoraclecore-api
git checkout previous-working-commit
npm install
pm2 restart dixoraclecore-api

# Using Docker
docker tag dixoraclecore-api:latest dixoraclecore-api:backup
docker pull dixoraclecore-api:previous-version
docker run dixoraclecore-api:previous-version
```

## Troubleshooting

Common issues and solutions in production:

1. **High memory usage**: Increase instance size or optimize code
2. **Slow API responses**: Add caching, optimize queries
3. **Database connection errors**: Check connection pool settings
4. **SSL certificate expired**: Renew with Certbot
5. **Out of disk space**: Clean logs, increase storage

## Support

For deployment issues, check:
- Platform documentation (Vercel, Render, etc.)
- Docker documentation
- Nginx documentation
- MongoDB Atlas documentation

---

**Note**: This is a general deployment guide. Specific steps may vary based on your infrastructure choices.
