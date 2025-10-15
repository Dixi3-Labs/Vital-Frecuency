#!/bin/bash
# Installation and verification script for Dix Oracle Core

set -e

echo "===== Dix Oracle Core - Installation Script ====="
echo ""

# Check prerequisites
echo "Checking prerequisites..."
command -v node >/dev/null 2>&1 || { echo "Error: Node.js is required but not installed."; exit 1; }
command -v npm >/dev/null 2>&1 || { echo "Error: npm is required but not installed."; exit 1; }
command -v python3 >/dev/null 2>&1 || { echo "Warning: Python 3 is recommended for core-ai module.";}

echo "Node.js version: $(node --version)"
echo "npm version: $(npm --version)"
if command -v python3 >/dev/null 2>&1; then
  echo "Python version: $(python3 --version)"
fi
echo ""

# Install web module
echo "===== Installing Web Module ====="
cd web
npm install
echo "✓ Web module installed"
cd ..
echo ""

# Install api-server module
echo "===== Installing API Server Module ====="
cd api-server
npm install
echo "✓ API Server module installed"
cd ..
echo ""

# Install desktop module
echo "===== Installing Desktop Module ====="
cd desktop
npm install
echo "✓ Desktop module installed"
cd ..
echo ""

# Install core-ai module (if Python is available)
if command -v python3 >/dev/null 2>&1; then
  echo "===== Installing Core AI Module ====="
  cd core-ai
  if [ ! -d "venv" ]; then
    python3 -m venv venv
  fi
  source venv/bin/activate || . venv/Scripts/activate 2>/dev/null
  pip install -r requirements.txt
  deactivate 2>/dev/null || true
  echo "✓ Core AI module installed"
  cd ..
  echo ""
else
  echo "Skipping Core AI module (Python not found)"
  echo ""
fi

echo "===== Installation Complete ====="
echo ""
echo "Next steps:"
echo "1. Configure environment variables:"
echo "   - Copy api-server/.env.example to api-server/.env and configure"
echo ""
echo "2. Start the services:"
echo "   - Web: cd web && npm run dev"
echo "   - API: cd api-server && npm run dev"
echo "   - Desktop: cd desktop && npm start"
echo "   - AI (with Python): cd core-ai && source venv/bin/activate && uvicorn main:app --reload"
echo ""
