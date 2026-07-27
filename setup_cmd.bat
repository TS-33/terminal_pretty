@echo off
setlocal DisableDelayedExpansion
chcp 65001 >nul

set "BIN_DIR=%USERPROFILE%\bin"
set "WELCOME_FILE=%BIN_DIR%\welcome.bat"
set "BASHRC_FILE=%BIN_DIR%\bashrc.bat"

if not exist "%BIN_DIR%" mkdir "%BIN_DIR%"
if exist "%WELCOME_FILE%" del "%WELCOME_FILE%"
if exist "%BASHRC_FILE%" del "%BASHRC_FILE%"

for /f "usebackq tokens=1,* delims=^|" %%A in ("%~f0") do if "%%A"=="REM_WELCOME" >> "%WELCOME_FILE%" echo(%%B

>> "%BASHRC_FILE%" echo @echo off
>> "%BASHRC_FILE%" echo call "%%USERPROFILE%%\bin\welcome.bat"

reg add "HKEY_CURRENT_USER\Software\Microsoft\Command Processor" /v AutoRun /t REG_SZ /d "%BASHRC_FILE%" /f

pause
exit /b 0

REM_WELCOME|@echo off
REM_WELCOME|chcp 65001 >nul
REM_WELCOME|cls
REM_WELCOME|
REM_WELCOME|set /a "rand=%RANDOM% %% 3"
REM_WELCOME|
REM_WELCOME|if %rand%==0 goto cat1
REM_WELCOME|if %rand%==1 goto cat2
REM_WELCOME|if %rand%==2 goto cat3
REM_WELCOME|exit /b 0
REM_WELCOME|
REM_WELCOME|:cat1
REM_WELCOME|echo(
REM_WELCOME|echo(
REM_WELCOME|echo(      ████          ████          
REM_WELCOME|echo(      ██  ██      ██  ██          
REM_WELCOME|echo(    ██      ██████      ██        
REM_WELCOME|echo(    ██                  ██        
REM_WELCOME|echo(  ██                      ██      
REM_WELCOME|echo(██████    ██      ██    ██████    
REM_WELCOME|echo(  ██      ██  ██  ██      ██      
REM_WELCOME|echo(██████      ██████      ██████    
REM_WELCOME|echo(  ██                      ██      
REM_WELCOME|echo(    ██                  ██        
REM_WELCOME|echo(      ████  ██████  ████          
REM_WELCOME|echo(
REM_WELCOME|echo(
REM_WELCOME|echo(
REM_WELCOME|exit /b 0
REM_WELCOME|
REM_WELCOME|:cat2
REM_WELCOME|echo(
REM_WELCOME|echo(
REM_WELCOME|echo(    ██          ██
REM_WELCOME|echo(  ██  ██      ██  ██
REM_WELCOME|echo(  ██    ██████      ██
REM_WELCOME|echo(  ██                ██
REM_WELCOME|echo(██                    ██
REM_WELCOME|echo(██    ██      ██      ██
REM_WELCOME|echo(██    ██      ██      ██   ██
REM_WELCOME|echo(██                    ██  ██
REM_WELCOME|echo(  ██      ██        ████  ██
REM_WELCOME|echo(    ██████████    ██    ██
REM_WELCOME|echo(            ██          ██
REM_WELCOME|echo(            ██  ██  ██  ██
REM_WELCOME|echo(              ██████████
REM_WELCOME|echo(
REM_WELCOME|echo(
REM_WELCOME|exit /b 0
REM_WELCOME|
REM_WELCOME|:cat3
REM_WELCOME|echo(
REM_WELCOME|echo(                             Meow~
REM_WELCOME|echo(
REM_WELCOME|echo(
REM_WELCOME|echo(     ████          ████
REM_WELCOME|echo(   ██    ██      ██    ██
REM_WELCOME|echo(   ██      ██████      ██
REM_WELCOME|echo(   ██                  ██
REM_WELCOME|echo( ██                      ██
REM_WELCOME|echo( ██                      ██
REM_WELCOME|echo( ██    ██          ██    ██
REM_WELCOME|echo( ██          ██          ██
REM_WELCOME|echo( ██                      ██
REM_WELCOME|echo(   ██                  ██
REM_WELCOME|echo(     ██████████████████    ██
REM_WELCOME|echo(     ██              ██  ███
REM_WELCOME|echo(     ██      ██      ██████
REM_WELCOME|echo(     ██    ██  ██    ████
REM_WELCOME|echo(     ██    ██  ██    ██
REM_WELCOME|echo(     ██████      ██████
REM_WELCOME|echo(
REM_WELCOME|echo(
REM_WELCOME|exit /b 0
