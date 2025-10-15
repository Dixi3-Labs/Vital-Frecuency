#!/bin/bash
# Verification script for Dix Oracle Core project structure

echo "===== Dix Oracle Core - Project Structure Verification ====="
echo ""

ERRORS=0
WARNINGS=0

# Function to check if file exists
check_file() {
  if [ -f "$1" ]; then
    echo "✓ $1"
  else
    echo "✗ $1 - MISSING"
    ((ERRORS++))
  fi
}

# Function to check if directory exists
check_dir() {
  if [ -d "$1" ]; then
    echo "✓ $1/"
  else
    echo "✗ $1/ - MISSING"
    ((ERRORS++))
  fi
}

# Function to check optional file
check_optional() {
  if [ -f "$1" ]; then
    echo "✓ $1 (optional)"
  else
    echo "⚠ $1 - NOT FOUND (optional)"
    ((WARNINGS++))
  fi
}

echo "Checking root files..."
check_file "README.md"
check_file "QUICKSTART.md"
check_file "ARCHITECTURE.md"
check_file "CONTRIBUTING.md"
check_file "package.json"
check_file "install.sh"
check_file "install.bat"
check_file ".gitignore"
echo ""

echo "Checking web module..."
check_dir "web"
check_dir "web/src"
check_dir "web/src/pages"
check_file "web/package.json"
check_file "web/index.html"
check_file "web/vite.config.ts"
check_file "web/tsconfig.json"
check_file "web/src/main.tsx"
check_file "web/src/App.tsx"
check_file "web/src/theme.ts"
check_file "web/src/pages/Home.tsx"
check_file "web/src/pages/Dashboard.tsx"
check_file "web/src/pages/Login.tsx"
check_file "web/src/pages/Overlay.tsx"
check_file "web/src/pages/Reports.tsx"
check_file "web/.gitignore"
check_file "web/.eslintrc.cjs"
echo ""

echo "Checking api-server module..."
check_dir "api-server"
check_dir "api-server/src"
check_file "api-server/package.json"
check_file "api-server/src/index.js"
check_file "api-server/.env.example"
check_file "api-server/.gitignore"
echo ""

echo "Checking core-ai module..."
check_dir "core-ai"
check_file "core-ai/main.py"
check_file "core-ai/requirements.txt"
check_file "core-ai/.gitignore"
echo ""

echo "Checking desktop module..."
check_dir "desktop"
check_file "desktop/package.json"
check_file "desktop/main.js"
check_file "desktop/.gitignore"
echo ""

echo "Checking android module..."
check_dir "android"
check_dir "android/app"
check_file "android/build.gradle"
check_file "android/settings.gradle"
check_file "android/gradle.properties"
check_file "android/app/build.gradle"
check_file "android/app/src/main/AndroidManifest.xml"
check_file "android/app/src/main/java/com/dixoraclecore/MainActivity.kt"
check_file "android/.gitignore"
echo ""

echo "Checking optional dependencies..."
check_optional "web/node_modules"
check_optional "api-server/node_modules"
check_optional "desktop/node_modules"
check_optional "core-ai/venv"
echo ""

echo "===== Summary ====="
echo "Errors: $ERRORS"
echo "Warnings: $WARNINGS"
echo ""

if [ $ERRORS -eq 0 ]; then
  echo "✓ All required files and directories are present!"
  echo ""
  echo "Next steps:"
  echo "1. Run './install.sh' to install dependencies"
  echo "2. Configure api-server/.env"
  echo "3. Start development servers (see QUICKSTART.md)"
  exit 0
else
  echo "✗ Some required files or directories are missing."
  echo "Please ensure the project structure is complete."
  exit 1
fi
