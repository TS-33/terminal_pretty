@echo off
setlocal DisableDelayedExpansion
chcp 65001 >nul

set "BIN_DIR=%USERPROFILE%\bin"
set "WELCOME_DIR=%BIN_DIR%\welcome"
set "WELCOME_FILE=%BIN_DIR%\welcome.bat"
set "BASHRC_FILE=%BIN_DIR%\bashrc.bat"

rem ============================================================
rem 创建目录
rem ============================================================

if not exist "%BIN_DIR%" mkdir "%BIN_DIR%"
if not exist "%WELCOME_DIR%" mkdir "%WELCOME_DIR%"

rem ============================================================
rem 删除旧的随机选择程序
rem ============================================================

if exist "%WELCOME_FILE%" del /q "%WELCOME_FILE%"

rem ============================================================
rem 生成 welcome.bat
rem
rem 这个程序会随机选择 welcome 目录中的一个 .bat
rem ============================================================

(
    echo @echo off
    echo setlocal EnableDelayedExpansion
    echo.
    echo set "WELCOME_DIR=%%~dp0welcome"
    echo.
    echo set /a count=0
    echo.
    echo for %%%%F in ^("%%WELCOME_DIR%%\*.bat"^) do ^(
    echo     if exist "%%%%~fF" ^(
    echo         set /a count+=1
    echo         set "file[!count!]=%%%%~fF"
    echo     ^)
    echo ^)
    echo.
    echo if !count! LEQ 0 ^(
    echo     endlocal
    echo     exit /b 0
    echo ^)
    echo.
    echo set /a "rand=!RANDOM! %%%% count + 1"
    echo.
    echo for %%%%I in ^(!rand!^) do call "!file[%%%%I]!"
    echo.
    echo endlocal
    echo exit /b 0
) > "%WELCOME_FILE%"

rem ============================================================
rem 生成 bashrc.bat
rem ============================================================

(
    echo @echo off
    echo call "%%USERPROFILE%%\bin\welcome.bat"
) > "%BASHRC_FILE%"

rem ============================================================
rem 提取并生成 welcome/*.bat
rem
rem 格式：
rem REM_WELCOME|文件名|文件内容
rem ============================================================

for /f "usebackq tokens=1,2,* delims=|" %%A in ("%~f0") do (
    if "%%A"=="REM_WELCOME" (
        if not defined REM_WELCOME_CLEARED_%%B (
            type nul >"%WELCOME_DIR%\%%B"
            set "REM_WELCOME_CLEARED_%%B=1"
        )
        >>"%WELCOME_DIR%\%%B" echo(%%C
    )
)

rem ============================================================
rem 设置 CMD AutoRun
rem ============================================================

reg add "HKEY_CURRENT_USER\Software\Microsoft\Command Processor" ^
    /v AutoRun ^
    /t REG_SZ ^
    /d "%BASHRC_FILE%" ^
    /f >nul

echo.
echo ==========================================
echo  CMD Welcome installed successfully!
echo ==========================================
echo.
echo  Welcome directory:
echo  %WELCOME_DIR%
echo.
echo  Available welcome programs:
dir /b "%WELCOME_DIR%\*.bat" 2>nul
echo.
echo  Add your own .bat files to this directory.
echo  They will automatically participate in random selection.
echo.

pause
exit /b 0


REM_WELCOME|cat1.bat|@echo off
REM_WELCOME|cat1.bat|chcp 65001 >nul
REM_WELCOME|cat1.bat|echo(
REM_WELCOME|cat1.bat|echo(
REM_WELCOME|cat1.bat|echo(      ████          ████
REM_WELCOME|cat1.bat|echo(      ██  ██      ██  ██
REM_WELCOME|cat1.bat|echo(    ██      ██████      ██
REM_WELCOME|cat1.bat|echo(    ██                  ██
REM_WELCOME|cat1.bat|echo(  ██                      ██
REM_WELCOME|cat1.bat|echo(██████    ██      ██    ██████
REM_WELCOME|cat1.bat|echo(  ██      ██  ██  ██      ██
REM_WELCOME|cat1.bat|echo(██████      ██████      ██████
REM_WELCOME|cat1.bat|echo(  ██                      ██
REM_WELCOME|cat1.bat|echo(    ██                  ██
REM_WELCOME|cat1.bat|echo(      ████  ██████  ████
REM_WELCOME|cat1.bat|echo(
REM_WELCOME|cat1.bat|echo(
REM_WELCOME|cat1.bat|exit /b 0


REM_WELCOME|cat2.bat|@echo off
REM_WELCOME|cat2.bat|chcp 65001 >nul
REM_WELCOME|cat2.bat|echo(
REM_WELCOME|cat2.bat|echo(
REM_WELCOME|cat2.bat|echo(    ██          ██
REM_WELCOME|cat2.bat|echo(  ██  ██      ██  ██
REM_WELCOME|cat2.bat|echo(  ██    ██████      ██
REM_WELCOME|cat2.bat|echo(  ██                ██
REM_WELCOME|cat2.bat|echo(██                    ██
REM_WELCOME|cat2.bat|echo(██    ██      ██      ██
REM_WELCOME|cat2.bat|echo(██    ██      ██      ██   ██
REM_WELCOME|cat2.bat|echo(██                    ██  ██
REM_WELCOME|cat2.bat|echo(  ██      ██        ████  ██
REM_WELCOME|cat2.bat|echo(    ██████████    ██    ██
REM_WELCOME|cat2.bat|echo(            ██          ██
REM_WELCOME|cat2.bat|echo(            ██  ██  ██  ██
REM_WELCOME|cat2.bat|echo(              ██████████
REM_WELCOME|cat2.bat|echo(
REM_WELCOME|cat2.bat|echo(
REM_WELCOME|cat2.bat|exit /b 0


REM_WELCOME|cat3.bat|@echo off
REM_WELCOME|cat3.bat|chcp 65001 >nul
REM_WELCOME|cat3.bat|echo(
REM_WELCOME|cat3.bat|echo(                             Meow~
REM_WELCOME|cat3.bat|echo(
REM_WELCOME|cat3.bat|echo(
REM_WELCOME|cat3.bat|echo(     ████          ████
REM_WELCOME|cat3.bat|echo(   ██    ██      ██    ██
REM_WELCOME|cat3.bat|echo(   ██      ██████      ██
REM_WELCOME|cat3.bat|echo(   ██                  ██
REM_WELCOME|cat3.bat|echo( ██                      ██
REM_WELCOME|cat3.bat|echo( ██                      ██
REM_WELCOME|cat3.bat|echo( ██    ██          ██    ██
REM_WELCOME|cat3.bat|echo( ██          ██          ██
REM_WELCOME|cat3.bat|echo( ██                      ██
REM_WELCOME|cat3.bat|echo(   ██                  ██
REM_WELCOME|cat3.bat|echo(     ██████████████████    ██
REM_WELCOME|cat3.bat|echo(     ██              ██  ███
REM_WELCOME|cat3.bat|echo(     ██      ██      ██████
REM_WELCOME|cat3.bat|echo(     ██    ██  ██    ████
REM_WELCOME|cat3.bat|echo(     ██    ██  ██    ██
REM_WELCOME|cat3.bat|echo(     ██████      ██████
REM_WELCOME|cat3.bat|echo(
REM_WELCOME|cat3.bat|echo(
REM_WELCOME|cat3.bat|exit /b 0
