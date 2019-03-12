@echo off

::获取管理员权限
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit
cd /d "%~dp0"

::命令行标题栏和文字颜色
title -- v2ray便捷启动脚本 --
MODE con: COLS=53 lines=9
color 0a

::主菜单
:begin
cls
MODE con: COLS=53 lines=9
echo.
echo.          ===== v2ray便捷启动脚本 =====
echo.
echo.   --[1]--安装桌面右键快速启动菜单
echo.   --[2]--删除桌面右键快速启动菜单
echo.
choice /c 12 /n /m "请选择【1-2】："

echo %errorlevel%
if %errorlevel% == 1 goto install
if %errorlevel% == 2 goto uninstall

::卸载右键
:uninstall
cls
echo Windows Registry Editor Version 5.00 >>dkey.reg
echo [-HKEY_CLASSES_ROOT\DesktopBackground\Shell\V2ray] >>dkey.reg
echo [-HKEY_CLASSES_ROOT\DesktopBackground\Shell\V2ray\command] >>dkey.reg

ping localhost -n 2 1>nul 2>nul
regedit /s dkey.reg
del /q dkey.reg

echo.
echo.
echo 卸载成功。
ping localhost -n 2 1>nul 2>nul
goto begin

::安装右键
:install
cls
set name=切换v2ray线路

set path1=%cd%
cd ..
set path2=%cd%\便捷启动.bat
set "path2=%path2:\=\\%"
cd %path1%

echo Windows Registry Editor Version 5.00 >>rkey.reg
echo [HKEY_CLASSES_ROOT\DesktopBackground\Shell\V2ray] >>rkey.reg
echo @="%name%" >>rkey.reg
echo [HKEY_CLASSES_ROOT\DesktopBackground\Shell\V2ray\command] >>rkey.reg
echo @="%path2%" >>rkey.reg

ping localhost -n 2 1>nul 2>nul
regedit /s rkey.reg
del /q rkey.reg

echo.
echo.
echo 安装成功。
ping localhost -n 2 1>nul 2>nul
goto begin
