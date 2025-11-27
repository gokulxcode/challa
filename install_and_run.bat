@echo off
setlocal

REM Ensure we are at the repo root where this script lives
cd /d "%~dp0"

REM Create the Python virtual environment if it does not exist
if not exist ".venv" (
    echo Creating Python virtual environment...
    REM Try Python 3.11 first, then fall back to default Python
    py -3.11 -m venv .venv 2>nul || py -3 -m venv .venv 2>nul || python -m venv .venv
)

REM Activate the virtual environment for the remainder of this script
call ".venv\Scripts\activate.bat"

REM Upgrade pip tooling (best-effort) and install backend dependencies
python -m ensurepip --upgrade >nul
python -m pip install --upgrade pip setuptools wheel
python -m pip install -r backend\requirements.txt

REM Populate sample data (admin user + demo products) for the first run
python backend\populate_sample_data.py

REM Install frontend dependencies via npm
pushd frontend
if exist "package-lock.json" (
    npm install
) else (
    npm install
)
popd

REM Launch backend and frontend dev servers in separate windows
start "backend" cmd /k "cd /d \"%~dp0backend\" ^&^& call ..\.venv\Scripts\activate.bat ^&^& python -m uvicorn app.main:app --reload"
start "frontend" cmd /k "cd /d \"%~dp0frontend\" ^&^& npm run dev -- --host"

echo.
echo Backend and frontend dev servers are starting in their own windows.
echo Close those windows to stop the services.
pause

