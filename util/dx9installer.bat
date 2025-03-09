@echo off
setlocal

:: Ask the user for an installation directory
set installdir="%USERPROFILE%/Downloads"

:: Resolve full path
for %%I in ("%installdir%") do set "installdir=%%~fI"

:: Ensure the directory exists
if not exist "%installdir%" mkdir "%installdir%"

:: Check if the directory is writable
echo Testing Write Access > "%installdir%\test_write_access.txt"
if not exist "%installdir%\test_write_access.txt" (
    echo ERROR: The directory "%installdir%" is protected or not writable.
    pause
    exit /b 1
)
del "%installdir%\test_write_access.txt"

:: Define the URL and ZIP file name
set "zipurl=https://example.com/files/archive.zip"
set "zipfile=%installdir%\dx9.zip"

:: Download the ZIP file using curl
echo Downloading ZIP file...
curl -o "%zipfile%" "%zipurl%" --show-error
if %errorlevel% neq 0 (
    echo ERROR: Failed to download DirectX 9 files.
    pause
    exit /b 1
)

:: Extract ZIP using PowerShell
echo Extracting installed archive...
powershell -Command "Expand-Archive -Path '%zipfile%' -DestinationPath '%installdir%' -Force"

if %errorlevel% neq 0 (
    echo ERROR: Extraction failed.
    pause
    exit /b 1
)

:: Optional: Delete the ZIP file after extraction
del "%zipfile%"

echo Installation complete!
pause
