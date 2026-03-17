@echo off
echo.
echo ========================================
echo   SpotyBot Installation Script
echo ========================================
echo.

REM Use PowerShell (pwsh if available) to install ffmpeg and Python when missing
where pwsh >nul 2>&1
if %errorlevel%==0 (
    set "PWSH_CMD=pwsh -NoProfile -ExecutionPolicy Bypass -Command"
) else (
    set "PWSH_CMD=powershell -NoProfile -ExecutionPolicy Bypass -Command"
)

echo Checking for winget and installing ffmpeg first...
%PWSH_CMD% "if (Get-Command winget -ErrorAction SilentlyContinue) { Write-Output 'winget-found'; exit 0 } else { Write-Output 'winget-missing'; exit 1 }" >nul 2>&1
if errorlevel 1 (
    echo winget not available; skipping automatic ffmpeg install. Please install ffmpeg manually.
) else (
    echo Installing ffmpeg via winget (may require admin rights)...
    %PWSH_CMD% "winget install ffmpeg --accept-package-agreements --accept-source-agreements --silent" || (
        echo winget ffmpeg install failed; attempting without --silent...
        %PWSH_CMD% "winget install ffmpeg --accept-package-agreements --accept-source-agreements"
    )
)

REM Check for python (or the py launcher)
where python >nul 2>&1
if errorlevel 1 (
    where py >nul 2>&1
    if errorlevel 1 (
        echo Python not found. Attempting to install Python via winget/powershell...
        %PWSH_CMD% "if (Get-Command winget -ErrorAction SilentlyContinue) { exit 0 } else { exit 1 }"
        if errorlevel 1 (
            echo winget not available. Falling back to downloading Python installer from python.org
            %PWSH_CMD% "$out = Join-Path $env:TEMP 'python-installer.exe'; Invoke-WebRequest -Uri 'https://www.python.org/ftp/python/3.11.4/python-3.11.4-amd64.exe' -OutFile $out -UseBasicParsing; Start-Process -FilePath $out -ArgumentList '/quiet','InstallAllUsers=1','PrependPath=1','Include_pip=1' -Wait; if (Get-Command python -ErrorAction SilentlyContinue) { exit 0 } else { exit 2 }"
            if errorlevel 2 (
                echo ERROR: Automatic python install failed. Please install Python 3.8+ manually and re-run this script.
                pause
                exit /b 1
            )
        ) else (
            echo Installing Python via winget (may require admin rights)...
            %PWSH_CMD% "winget install --id=Python.Python.3 -e --accept-package-agreements --accept-source-agreements --silent" || (
                echo winget python install failed; attempting generic 'python' package...
                %PWSH_CMD% "winget install python --accept-package-agreements --accept-source-agreements"
            )
        )
    ) else (
        echo Found 'py' launcher; using that for pip operations
    )
) else (
    echo Python found.
    python --version
)

echo.
echo Installing Python dependencies (using available Python executable)...
where python >nul 2>&1
if errorlevel 1 (
    where py >nul 2>&1 && set "PY_CMD=py -3 -m" || (
        echo ERROR: Python not found after install attempts. Please restart your shell or add Python to PATH.
        pause
        exit /b 1
    )
) else (
    set "PY_CMD=python -m"
)

%PY_CMD% pip install -r requirements.txt

if errorlevel 1 (
    echo ERROR: Failed to install dependencies
    pause
    exit /b 1
)

echo.
echo Installing SpotyBot package in editable mode...
%PY_CMD% pip install -e .

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