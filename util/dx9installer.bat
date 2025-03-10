@echo off
setlocal
set installdir="%USERPROFILE%/Downloads"
for %%I in ("%installdir%") do set "installdir=%%~fI"

:: Ensure the directory exists
if not exist "%installdir%" mkdir "%installdir%"

:: Check if the directory is writable
echo Testing Write Access > "%installdir%\test_write_access.txt"
if not exist "%installdir%\test_write_access.txt" (
    echo ERROR: The directory "%installdir%" is protected or not writable. Check the help or Wiki for fixes.
    pause
    exit /b 1
)
del "%installdir%\test_write_access.txt"

:: Define the URL and ZIP file name
set "zipurl=https://zephyrgddp.github.io/DLLlibBeta/dlls/dx9.zip"
set "zipfile=%installdir%\dx9.zip"

:: Download the ZIP file using curl
echo Installing archive...
powershell -Command "Invoke-WebRequest -Uri '%zipurl%'"

:: Extract ZIP using PowerShell
echo Extracting archive...
powershell -Command "Expand-Archive -Path '%zipfile%' -DestinationPath '%installdir%' -Force"

if %errorlevel% neq 0 (
    echo ERROR: Extraction failed.
    pause
    exit /b 1
)

:: Optional: Delete the ZIP file after extraction
del "%zipfile%"

echo DirectX 9 was installed to Downloads.
pause
