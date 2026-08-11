@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
reg add "HKCU\Console" /v VirtualTerminalLevel /t REG_DWORD /d 1 /f >nul 2>nul

set "ESC="
set "RESET=!ESC![0m"
set "BLOCK=  "
set "SAMPLE=░▒▓█"

if /i "%~1"=="--rgb-all" goto rgb_all
if /i "%~1"=="/rgb-all" goto rgb_all
if /i "%~1"=="--help" goto help
if /i "%~1"=="/?" goto help

call :header
call :basic_16
call :palette_256
call :truecolor_preview

echo.
echo 说明：现代 ANSI 终端通常支持 24-bit True Color，即 RGB 000000-FFFFFF，合计 16,777,216 色。
echo       默认页面完整列出 0-255 索引色；真彩色数量过大，使用 RGB 渐变验证支持。
echo       如确实要枚举全部 16,777,216 个 RGB 值，请运行：%~nx0 --rgb-all ^> rgb_all.txt
echo.
if /i not "%~1"=="--no-pause" pause
exit /b

:header
echo.
echo ============================================================
echo  现代终端颜色总览 / ANSI VT Colors
echo ============================================================
echo.
echo 支持层级：
echo  1. 基础 16 色：SGR 30-37/90-97 与 40-47/100-107
echo  2. 完整 256 色：ANSI 38;5;n / 48;5;n，n = 0..255
echo  3. 真彩色：ANSI 38;2;R;G;B / 48;2;R;G;B，R/G/B = 0..255
exit /b

:basic_16
set "FG0=30" & set "FG1=34" & set "FG2=32" & set "FG3=36"
set "FG4=31" & set "FG5=35" & set "FG6=33" & set "FG7=37"
set "FG8=90" & set "FG9=94" & set "FGA=92" & set "FGB=96"
set "FGC=91" & set "FGD=95" & set "FGE=93" & set "FGF=97"
set "BG0=40" & set "BG1=44" & set "BG2=42" & set "BG3=46"
set "BG4=41" & set "BG5=45" & set "BG6=43" & set "BG7=47"
set "BG8=100" & set "BG9=104" & set "BGA=102" & set "BGB=106"
set "BGC=101" & set "BGD=105" & set "BGE=103" & set "BGF=107"

echo.
echo [1/3] 基础 16 色：前景 x 背景，单元格 = %SAMPLE%
echo.
<nul set /p "=BG\FG "
for %%F in (0 1 2 3 4 5 6 7 8 9 A B C D E F) do <nul set /p "=  %%F  "
echo.
for %%B in (0 1 2 3 4 5 6 7 8 9 A B C D E F) do (
    <nul set /p "=  %%B   "
    for %%F in (0 1 2 3 4 5 6 7 8 9 A B C D E F) do (
        for %%# in (!FG%%F!) do for %%@ in (!BG%%B!) do <nul set /p "=!ESC![%%@;%%#m%SAMPLE%!RESET! "
    )
    echo.
)
exit /b

:palette_256
echo.
echo [2/3] 完整 256 色索引表：背景色 48;5;n，n = 0..255
echo.
echo 基础 0-15：
for /L %%N in (0,1,15) do call :print_256_cell %%N
echo.
echo.
echo 6x6x6 色立方 16-231：每 36 色一组；RGB 分量为 00, 5F, 87, AF, D7, FF
for /L %%R in (0,1,5) do (
    echo.
    echo R=%%R
    for /L %%G in (0,1,5) do (
        <nul set /p "=G=%%G "
        for /L %%B in (0,1,5) do (
            set /A "N=16 + 36*%%R + 6*%%G + %%B"
            call :print_256_cell !N!
        )
        echo.
    )
)
echo.
echo 灰阶 232-255：
for /L %%N in (232,1,255) do call :print_256_cell %%N
echo.
exit /b

:print_256_cell
set "N=%~1"
set "PAD=  !N!"
set "PAD=!PAD:~-3!"
if %~1 LSS 16 (set "TEXT_FG=15") else if %~1 GEQ 232 if %~1 LSS 244 (set "TEXT_FG=15") else (set "TEXT_FG=0")
if %~1 GEQ 16 if %~1 LSS 232 set "TEXT_FG=0"
<nul set /p "=!ESC![48;5;%~1;38;5;!TEXT_FG!m !PAD! !RESET!"
exit /b

:truecolor_preview
echo.
echo [3/3] 真彩色 RGB 预览：背景色 48;2;R;G;B
echo.
echo 红色通道 R 0..255：
call :rgb_line 255 0 0
echo 绿色通道 G 0..255：
call :rgb_line 0 255 0
echo 蓝色通道 B 0..255：
call :rgb_line 0 0 255
echo 灰阶 R=G=B 0..255：
for /L %%I in (0,1,63) do (
    set /A "V=%%I*255/63"
    <nul set /p "=!ESC![48;2;!V!;!V!;!V!m%BLOCK%!RESET!"
)
echo.
echo.
echo RGB 色相/亮度示例：
for %%L in (64 128 192 255) do (
    <nul set /p "=L=%%L "
    call :rgb_cell 255 0 0 %%L
    call :rgb_cell 255 128 0 %%L
    call :rgb_cell 255 255 0 %%L
    call :rgb_cell 128 255 0 %%L
    call :rgb_cell 0 255 0 %%L
    call :rgb_cell 0 255 128 %%L
    call :rgb_cell 0 255 255 %%L
    call :rgb_cell 0 128 255 %%L
    call :rgb_cell 0 0 255 %%L
    call :rgb_cell 128 0 255 %%L
    call :rgb_cell 255 0 255 %%L
    call :rgb_cell 255 0 128 %%L
    echo.
)
exit /b

:rgb_cell
set /A "RR=%~1*%~4/255, GG=%~2*%~4/255, BB=%~3*%~4/255"
<nul set /p "=!ESC![48;2;!RR!;!GG!;!BB!m%BLOCK%!RESET!"
exit /b

:rgb_line
for /L %%I in (0,1,63) do (
    set /A "R=%%I*%~1/63, G=%%I*%~2/63, B=%%I*%~3/63"
    <nul set /p "=!ESC![48;2;!R!;!G!;!B!m%BLOCK%!RESET!"
)
echo.
exit /b

:rgb_all
echo 正在枚举全部 24-bit True Color：16,777,216 个 RGB 值。建议重定向到文件。
echo 格式：HEX  RGB  色块
for /L %%R in (0,1,255) do (
    for /L %%G in (0,1,255) do (
        for /L %%B in (0,1,255) do (
            call :to_hex %%R HR
            call :to_hex %%G HG
            call :to_hex %%B HB
            echo #!HR!!HG!!HB!  RGB(%%R,%%G,%%B^)  !ESC![48;2;%%R;%%G;%%Bm%BLOCK%!RESET!
        )
    )
)
exit /b

:to_hex
set "HEX=0123456789ABCDEF"
set /A "HI=%~1/16, LO=%~1%%16"
for %%H in (!HI!) do for %%L in (!LO!) do set "%~2=!HEX:~%%H,1!!HEX:~%%L,1!"
exit /b

:help
echo 用法：%~nx0 [--no-pause]
echo       %~nx0 --rgb-all ^> rgb_all.txt
echo.
echo 默认显示完整 16 色、完整 256 色，以及 24-bit True Color 预览。
echo --rgb-all 会枚举全部 16,777,216 个 RGB 值，输出非常大且很慢。
exit /b
