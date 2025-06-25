@echo off
REM Change to the directory where this script resides
cd /d "%~dp0"

echo Adding all files...
git add .

REM Use the first argument as the commit message if provided
set MESSAGE=%1
if "%MESSAGE%"=="" set MESSAGE=Update project

echo Creating commit...
git commit -m "%MESSAGE%"

echo Pushing to GitHub...
git push origin main

echo Done!
pause
