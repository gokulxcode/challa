@echo off
setlocal

REM Change to repo root (folder containing this BAT)
cd /d "%~dp0"

REM Launch backend (FastAPI) in a new terminal window
echo Starting backend server...
start "backend-server" cmd /k "cd /d %cd%\backend && ..\.venv\Scripts\python -m uvicorn app.main:app --reload"

REM Launch frontend (Vite dev server) in a new terminal window
echo Starting frontend dev server...
start "frontend-server" cmd /k "cd /d %cd%\frontend && npm run dev -- --host"

echo.
echo Both servers are launching. Close the spawned terminal windows (backend-server / frontend-server)
echo to stop the processes.
endlocal

