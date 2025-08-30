@echo off
set PORT=5000

REM 引数があればポート番号を上書き
if not "%1"=="" (
    set PORT=%1
)

flutter run -d chrome --web-port=%PORT%
