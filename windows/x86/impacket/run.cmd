@echo off
REM CMD Batch File for Impacket Standalone Build
REM Uses CALL/GOTO structure to avoid CMD parsing conflicts (unexpected ')' error).

echo.
echo --- Starting Impacket Examples Bulk Build (CALL Method) ---
echo.

REM Loop through all .py files in the current directory.
for %%f in (*.py) do call :PROCESS_FILE "%%f"

echo.
echo --- Build Complete! ---
echo All standalone binaries (.exe) are available in the dist folder.

goto :EOF

REM =======================================================================
REM === Subroutine to Process Each File (Avoids Parsing Errors) ===
REM =======================================================================

:PROCESS_FILE

REM %1 holds the full filename (e.g., "secretsdump.py")
set "FULL_FILE_NAME=%~1"

REM Extract the tool name (without .py extension)
set "TOOL_NAME=%~n1"

REM Skip internal files like __init__.py and setup.py
if "%TOOL_NAME%"=="__init__" goto :EOF
if "%TOOL_NAME%"=="setup" goto :EOF

echo.
echo Building tool: %TOOL_NAME%.exe ...

REM === User Mandated Command ===
REM Using only --onefile, --name, and --hidden-import impacket
pyinstaller --onefile %FULL_FILE_NAME% --name "%TOOL_NAME%" --hidden-import impacket -y

REM Check the exit code for failure
if errorlevel 1 (
    echo.
    echo !!! PyInstaller FAILED for: %TOOL_NAME%. Continuing with next tool. !!!
    echo.
)

goto :EOF