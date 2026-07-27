@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul

reg add "HKCU\Console" /v VirtualTerminalLevel /t REG_DWORD /d 1 /f >nul 2>nul
set "ESC="
set "RESET=!ESC![0m"
set "SHADES=░▒▓█"

set "FG0=30" & set "FG1=34" & set "FG2=32" & set "FG3=36"
set "FG4=31" & set "FG5=35" & set "FG6=33" & set "FG7=37"
set "FG8=90" & set "FG9=94" & set "FGA=92" & set "FGB=96"
set "FGC=91" & set "FGD=95" & set "FGE=93" & set "FGF=97"

set "BG0=40" & set "BG1=44" & set "BG2=42" & set "BG3=46"
set "BG4=41" & set "BG5=45" & set "BG6=43" & set "BG7=47"
set "BG8=100" & set "BG9=104" & set "BGA=102" & set "BGB=106"
set "BGC=101" & set "BGD=105" & set "BGE=103" & set "BGF=107"

echo.
echo CMD ANSI color blocks: foreground x background, cell = !SHADES!
echo.

<nul set /p "=BG\FG "
for %%F in (0 1 2 3 4 5 6 7 8 9 A B C D E F) do <nul set /p "=  %%F  "
echo.

for %%B in (0 1 2 3 4 5 6 7 8 9 A B C D E F) do (
    <nul set /p "=  %%B   "
    for %%F in (0 1 2 3 4 5 6 7 8 9 A B C D E F) do (
        for %%# in (!FG%%F!) do for %%@ in (!BG%%B!) do <nul set /p "=!ESC![%%@;%%#m!SHADES!!RESET! "
    )
    echo.
)

echo.
echo Foreground-only shades:
for %%F in (0 1 2 3 4 5 6 7 8 9 A B C D E F) do (
    for %%# in (!FG%%F!) do echo %%F  !ESC![%%#m!SHADES!!RESET!
)

echo.
echo Background-only shades:
for %%B in (0 1 2 3 4 5 6 7 8 9 A B C D E F) do (
    for %%@ in (!BG%%B!) do echo %%B  !ESC![%%@m!SHADES!!RESET!
)

echo.
if /i not "%~1"=="--no-pause" pause