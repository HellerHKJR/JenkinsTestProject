@echo off
setlocal enabledelayedexpansion

REM ============================================
REM Modify these variables only
REM ============================================
set PROJECT_NAME=QWER
set STARTUP_ARG=QWER/QWER.Config.xml
REM ============================================

REM Inno Setup compiler path
set "ISCC=C:\Program Files (x86)\Inno Setup 6\ISCC.exe"

echo ========================================
echo Local Installer Builder
echo ========================================
echo.

REM Extract config path
for /f "tokens=1 delims=/" %%a in ("%STARTUP_ARG%") do set EXTRACTED_CONFIG_PATH=%%a

REM XML file path
set "CONFIG_FILE=JenkinsTestProject\Config\%STARTUP_ARG%"
set "CONFIG_FILE=%CONFIG_FILE:/=\%"

if not exist "%CONFIG_FILE%" (
    echo Error: Config file not found at %CONFIG_FILE%
    goto :error
)

REM Read version from XML using PowerShell (more reliable)
for /f "delims=" %%v in ('powershell -NoProfile -Command "[xml]$xml = Get-Content '%CONFIG_FILE%'; $xml.Configuration.version"') do set VERSION=%%v

if "!VERSION!"=="" (
    echo Error: Could not read version from %CONFIG_FILE%
    goto :error
)

REM Print build parameters
echo Build Parameters:
echo  - ProjectName: %PROJECT_NAME%
echo  - StartupArg: %STARTUP_ARG%
echo  - ConfigPath: !EXTRACTED_CONFIG_PATH!
echo  - Version: !VERSION!
echo  - Config File: %CONFIG_FILE%
echo.
echo Building installer...
echo.

REM Run Inno Setup
"%ISCC%" /dVersionInfo=!VERSION! /dProjectName=%PROJECT_NAME% /dConfigPath=!EXTRACTED_CONFIG_PATH! inno_setup.iss

if !ERRORLEVEL! NEQ 0 goto :error

REM Success
echo.
echo ========================================
echo Success!
echo ========================================
echo.
echo Installer created:
echo  - HS3Output\HS3_%PROJECT_NAME%_Installer_v!VERSION!.exe
echo.
goto :end

:error
echo.
echo ========================================
echo Build failed!
echo ========================================
echo.

:end
pause