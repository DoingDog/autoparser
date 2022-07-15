@echo off
chcp 65001
cd /d %~dp0
cls
del /f /q *.bak
del /f /q *.txt
set cutting=4
set makefile=domains.ini
echo Init-OK!

:: get fine file
(findstr /b [0-9] %makefile%)>1.txt
(findstr /b [Aa-Zz] %makefile%)>>1.txt

::xc file
for /f "tokens=2 delims=:" %%a in ('find /c /v "" 1.txt')do set/a originalcount=%%a

set /a separatecount=%originalcount%/%cutting%
set /a declinedcutting=%cutting%-1
for /l %%a in (1,1,%declinedcutting%) do (
sed -n "1,%separatecount%p" 1.txt>firstcut%%a.txt
sed -i "1,%separatecount%d" 1.txt
)
type 1.txt>firstcut%cutting%.txt

for /l %%e in (1,1,%cutting%) do (
echo 1 > DDfirstcut%%e.txt
start /i /b microwave.cmd firstcut%%e.txt finalcut%%e.txt
)

:noback
echo NOT complete
cls
choice /t 5 /d y /n >nul
if exist DDfir* goto :noback

for %%a in (final*.txt) do (echo. >>%%a)
type final*.txt>doi.txt
s -u -i -o fin.txt doi.txt
echo # %date% %time% >>fin.txt
copy /y fin.txt ..\hosts.txt
del /f /q *.txt
