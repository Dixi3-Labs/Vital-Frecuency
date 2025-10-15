# Quick Start Guide - Dix Oracle Core

## Prerequisites

- Node.js 18+ and npm
- Python 3.8+ (optional, for AI module)
- MongoDB (optional, for API server)

## Installation

### Option 1: Automated Installation (Recommended)

**Linux/Mac:**
```bash
./install.sh
```

**Windows:**
```batch
install.bat
```

### Option 2: Manual Installation

#### 1. Web Frontend
```bash
cd web
npm install
```

#### 2. API Server
```bash
cd api-server
npm install
cp .env.example .env
# Edit .env with your configuration
```

#### 3. Desktop App
```bash
cd desktop
npm install
```

#### 4. AI Core (Optional)
```bash
cd core-ai
python3 -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate
pip install -r requirements.txt
```

## Running the Applications

### Start All Services

**Terminal 1 - API Server:**
```bash
cd api-server
npm run dev
# Runs on http://localhost:4000
```

**Terminal 2 - Web Frontend:**
```bash
cd web
npm run dev
# Runs on http://localhost:5173
```

**Terminal 3 - AI Core (Optional):**
```bash
cd core-ai
source venv/bin/activate
uvicorn main:app --reload --host 0.0.0.0 --port 8080
# Runs on http://localhost:8080
```

**Terminal 4 - Desktop App (Optional):**
```bash
cd desktop
npm start
# Opens Electron window pointing to http://localhost:5173
```

## Building for Production

### Web Frontend
```bash
cd web
npm run build
# Output: web/dist/
```

### Desktop App
```bash
cd desktop
npm run build  # (requires electron-builder setup)
```

## Project Structure

```
DixOracleCore/
├── web/              # React + TypeScript + Vite frontend
│   ├── src/
│   │   ├── pages/    # Route pages (Home, Dashboard, etc.)
│   │   ├── App.tsx   # Main app component
│   │   └── theme.ts  # Material-UI theme
│   └── package.json
├── api-server/       # Node.js + Express backend
│   ├── src/
│   │   └── index.js  # Main server file
│   └── package.json
├── core-ai/          # Python + FastAPI AI engine
│   ├── main.py       # FastAPI application
│   └── requirements.txt
├── desktop/          # Electron desktop app
│   ├── main.js       # Electron main process
│   └── package.json
└── android/          # Android WebView wrapper
    └── app/
```

## Available Routes (Web)

- `/` - Home page
- `/dashboard` - Main dashboard
- `/overlay` - Game overlay view
- `/login` - Login page
- `/reports` - Reports and analytics

## API Endpoints

- `GET /api/ping` - Health check endpoint

## Environment Variables

### API Server (.env)
```env
PORT=4000
MONGO_URL=mongodb://localhost:27017/dixoraclecore
SENTRY_DSN=your_sentry_dsn
JWT_SECRET=your_jwt_secret
```

## Troubleshooting

### Port Already in Use
If you see "port already in use" errors:
- Web: Change port in `web/vite.config.ts`
- API: Change PORT in `api-server/.env`
- AI: Use `--port` flag with uvicorn

### MongoDB Connection Error
Make sure MongoDB is running:
```bash
# Check if MongoDB is running
mongod --version
# Start MongoDB
mongod
```

### Missing Dependencies
Run the installation script again or install modules individually.

## Development Tips

1. **Hot Reload**: All dev servers support hot reload
2. **Debugging**: Use browser DevTools for web, Node debugger for backend
3. **Linting**: Run `npm run lint` in web/ directory
4. **Building**: Test production builds regularly

## Next Steps

1. Configure authentication providers in API server
2. Train/download ML models for core-ai
3. Customize the theme in `web/src/theme.ts`
4. Add your game-specific logic
5. Set up database schemas

## Support

For issues and questions, please check the main README.md or create an issue in the repository.
