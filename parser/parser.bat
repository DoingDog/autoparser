@echo off
chcp 65001
cd /d %~dp0

(for /f "eol=#" %%a in (domains.ini) do echo %%a)>>list.txt
cls
for /f %%i in (.\list.txt) do (
set ns=%%~i
goto :comd
)
:comd

set startline=1
for /f "tokens=2 delims=:" %%a in ('find /c /v "" list.txt') do set long=%%a

echo #%long% hosts parsed by %ns%>parsed.txt
echo.>>parsed.txt
echo # %date% %time%>>parsed.txt
echo.>>parsed.txt

:loop

for /f "tokens=* skip=%startline% " %%i in (.\list.txt) do (
set name=%%~i
goto :comp
)
:comp

dog %name% --edns=disable -H @%ns% -1 | findstr /v [Aa-Zz] >temp.txt
dog %name% AAAA --edns=disable -H @%ns% -1 | findstr /c:":" >>temp.txt
for /f %%i in (temp.txt) do (echo %%i %name%)>>parsed.txt

set/a startline+=1

if not %startline%==%long% goto :loop

echo.>>parsed.txt
echo # Ending...>>parsed.txt

copy /y parsed.txt ..\hosts.txt
del /f /q *.txt
exit
