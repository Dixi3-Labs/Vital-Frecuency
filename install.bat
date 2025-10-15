@echo off
REM Installation script for Dix Oracle Core (Windows)

echo ===== Dix Oracle Core - Installation Script =====
echo.

REM Check prerequisites
where node >nul 2>&1
if %errorlevel% neq 0 (
    echo Error: Node.js is required but not installed.
    exit /b 1
)

where npm >nul 2>&1
if %errorlevel% neq 0 (
    echo Error: npm is required but not installed.
    exit /b 1
)

echo Node.js version:
node --version
echo npm version:
npm --version
echo.

REM Install web module
echo ===== Installing Web Module =====
cd web
call npm install
if %errorlevel% neq 0 (
    echo Error installing web module
    exit /b 1
)
echo [OK] Web module installed
cd ..
echo.

REM Install api-server module
echo ===== Installing API Server Module =====
cd api-server
call npm install
if %errorlevel% neq 0 (
    echo Error installing api-server module
    exit /b 1
)
echo [OK] API Server module installed
cd ..
echo.

REM Install desktop module
echo ===== Installing Desktop Module =====
cd desktop
call npm install
if %errorlevel% neq 0 (
    echo Error installing desktop module
    exit /b 1
)
echo [OK] Desktop module installed
cd ..
echo.

echo ===== Installation Complete =====
echo.
echo Next steps:
echo 1. Configure environment variables:
echo    - Copy api-server\.env.example to api-server\.env and configure
echo.
echo 2. Start the services:
echo    - Web: cd web ^&^& npm run dev
echo    - API: cd api-server ^&^& npm run dev
echo    - Desktop: cd desktop ^&^& npm start
echo.
pause
