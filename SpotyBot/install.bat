@echo off
echo.
echo ========================================
echo   SpotyBot Installation Script
echo ========================================
echo.

REM Check if Python is installed
python --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Python is not installed or not in PATH
    echo Please install Python 3.8+ from https://python.org/downloads/
    pause
    exit /b 1
)

echo Python found:
python --version

echo.
echo Installing dependencies...
pip install -r requirements.txt

if errorlevel 1 (
    echo ERROR: Failed to install dependencies
    pause
    exit /b 1
)

echo.
echo Installing SpotyBot...
pip install -e .

if errorlevel 1 (
    echo ERROR: Failed to install SpotyBot
    pause
    exit /b 1
)

echo.
echo ========================================
echo   Installation Complete!
echo ========================================
echo.
echo Next steps:
echo 1. Run: spotybot setup
echo 2. Follow the setup wizard to configure your Spotify API credentials
echo 3. Start using SpotyBot: spotybot interactive
echo.
echo For help: spotybot --help
echo.
pause