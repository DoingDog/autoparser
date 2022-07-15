@echo off
chcp 65001
cd /d %~dp0
set ns=https://a.passcloud.xyz/sz
set minused=82

cls
for /f %%i in (domains.ini) do (
dog -H @%ns% --time %%i|findstr Ran>>testR.txt
)
for /f "skip=1 tokens=3 delims= " %%i in (testR.txt) do echo %%i>>testM.txt
for /f "tokens=1 delims=m" %%i in (testM.txt) do set/a tim+=%%i
set /a ta=%tim%/%minused%
del /f /q testM.txt
del /f /q testR.txt
color 0a
echo Average %ta% ms
pause
