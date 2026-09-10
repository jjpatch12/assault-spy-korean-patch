@echo off
chcp 65001 >nul
setlocal EnableExtensions DisableDelayedExpansion
title Assault Spy 한국어 패치 설치

set "PATCH_DATA=%~dp0.patch_data"
set "GAME_DIR=%~1"
set "SILENT_ARG=%~2"
attrib +h "%PATCH_DATA%" >nul 2>nul

if not exist "%PATCH_DATA%\manifest.json" (
  echo.
  echo [오류] 숨김 패치 데이터가 없습니다. ZIP 전체를 먼저 압축 해제하세요.
  if /I not "%SILENT_ARG%"=="/silent" pause
  exit /b 1
)

if defined GAME_DIR set "GAME_DIR=%GAME_DIR:"=%"
if not defined GAME_DIR if exist "%~dp0ASSAULT_SPY\Content\Paks\ASSAULT_SPY-WindowsNoEditor.pak" set "GAME_DIR=%~dp0"
if not defined GAME_DIR if exist "%USERPROFILE%\Desktop\Assault Spy\ASSAULT_SPY\Content\Paks\ASSAULT_SPY-WindowsNoEditor.pak" set "GAME_DIR=%USERPROFILE%\Desktop\Assault Spy"
if not defined GAME_DIR if exist "%ProgramFiles(x86)%\Steam\steamapps\common\Assault Spy\ASSAULT_SPY\Content\Paks\ASSAULT_SPY-WindowsNoEditor.pak" set "GAME_DIR=%ProgramFiles(x86)%\Steam\steamapps\common\Assault Spy"
if not defined GAME_DIR if exist "%ProgramFiles%\Steam\steamapps\common\Assault Spy\ASSAULT_SPY\Content\Paks\ASSAULT_SPY-WindowsNoEditor.pak" set "GAME_DIR=%ProgramFiles%\Steam\steamapps\common\Assault Spy"
if not defined GAME_DIR set /p "GAME_DIR=Assault Spy 게임 폴더 경로를 입력하세요: "
set "GAME_DIR=%GAME_DIR:"=%"
for %%I in ("%GAME_DIR%") do set "GAME_DIR=%%~fI"

if not exist "%GAME_DIR%\ASSAULT_SPY\Content\Paks\ASSAULT_SPY-WindowsNoEditor.pak" (
  echo.
  echo [오류] 올바른 Assault Spy 게임 폴더가 아닙니다.
  echo 선택 경로: %GAME_DIR%
  if /I not "%SILENT_ARG%"=="/silent" pause
  exit /b 2
)

tasklist /FI "IMAGENAME eq ASSAULT_SPY-Win64-Shipping.exe" 2>nul | findstr /I /C:"ASSAULT_SPY-Win64-Shipping.exe" >nul
if not errorlevel 1 (
  echo.
  echo [오류] 게임이 실행 중입니다. 게임을 완전히 종료한 뒤 다시 실행하세요.
  if /I not "%SILENT_ARG%"=="/silent" pause
  exit /b 3
)

echo.
echo Assault Spy 한국어 패치 v1.0을 설치합니다.
echo 대상: %GAME_DIR%
echo 기존 한국어 패치는 KoreanPatch_Backup 폴더에 자동 백업합니다.
echo.

powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -File "%PATCH_DATA%\install.ps1" -GameDirectory "%GAME_DIR%" -PayloadDirectory "%PATCH_DATA%"
set "INSTALL_RESULT=%ERRORLEVEL%"

if not "%INSTALL_RESULT%"=="0" (
  echo.
  echo [실패] 설치하지 못했습니다. 위 오류 내용을 확인하세요.
  if /I not "%SILENT_ARG%"=="/silent" pause
  exit /b 4
)

echo.
echo [완료] 한국어 패치 설치 및 해시 검증이 끝났습니다.
echo 설치된 PAK 4개는 숨김 속성으로 적용되었습니다.
if /I not "%SILENT_ARG%"=="/silent" pause
exit /b 0
