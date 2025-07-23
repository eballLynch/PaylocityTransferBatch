@echo off
:: -------------------------------------------------------------------------------------- MODIFY TO REFLECT PROPER LOCATIONS
set "sourceFile=C:\Users\eball\Desktop\Code\Paylocity\sourceFile\ABPayTEST4.txt"
set "destFolder=C:\Users\eball\Desktop\Code\Paylocity\destFolder"
set "backupFolder=C:\Users\eball\Desktop\Code\Paylocity\backupFolder"
echo Checking file: %sourceFile%
REM Check if source file exists
if not exist "%sourceFile%" (
    echo ERROR: Source file not found: %sourceFile%
    pause
    exit /b 1
)
REM Get file size in bytes
for %%A in ("%sourceFile%") do set fileSize=%%~zA
REM Convert bytes to KB
set /a fileSizeKB=%fileSize%/1024
echo File size: %fileSizeKB% KB (%fileSize% bytes)
echo.

:: -------------------------------------------------------------------------------------- MODIFY TO FIT CURRENT ENVIRONMENT PARAMETERS IE 300-400KB
REM Check file size constraints
if %fileSizeKB% LSS 300 (
    echo WARNING: File size ^(%fileSizeKB% KB^) is under 300 KB minimum requirement.
    echo.
    goto :askContinue
)
if %fileSizeKB% GTR 400 (
    echo WARNING: File size ^(%fileSizeKB% KB^) exceeds 400 KB maximum limit.
    echo.
    goto :askContinue
)
echo File size is within acceptable range ^(300-400 KB^). Proceeding automatically...
echo.
goto :proceedWithCopy

:: -------------------------------------------------------------------------------------- USER CONDITIONS LOGIC
:askContinue
echo Press Y to continue or any other key to cancel:
set /p userInput=
if /i "%userInput%"=="Y" (
    echo Continuing with file transfer...
    echo.
    goto :proceedWithCopy
)
echo.
echo Are you sure you want to cancel the operation? ^(Y/N^):
set /p cancelConfirm=
if /i "%cancelConfirm%"=="Y" (
    echo ============================
    echo.
    echo Operation cancelled by user.
    echo.
    echo ============================
    pause
    exit /b 0
)
echo Returning to file transfer...
echo.
goto :proceedWithCopy

:proceedWithCopy
REM Create timestamp
set timestamp=%date:~-4,4%%date:~-10,2%%date:~-7,2%_%time:~0,2%%time:~3,2%%time:~6,2%
set timestamp=%timestamp: =0%
REM Create destination paths
set "destFile=%destFolder%\abpay_%timestamp%.txt"
set "backupFile=%backupFolder%\abpay_%timestamp%.txt"
echo.
echo Copying files...
REM Copy to destination folder
copy "%sourceFile%" "%destFile%"
if errorlevel 1 (
    echo ERROR: Failed to copy to destination folder.
    pause
    exit /b 1
)
REM Copy to backup location
copy "%sourceFile%" "%backupFile%"
if errorlevel 1 (
    echo ERROR: Failed to copy to backup location.
    pause
    exit /b 1
)
echo.
echo.
echo.
echo The TCM file ABPAY has been transferred to the Paylocity folder
echo Destination: %destFile%
echo Backup: %backupFile%
echo File size: %fileSizeKB% KB
pause
