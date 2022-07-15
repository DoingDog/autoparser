@echo off
chcp 65001
cd /d %~dp0
cls

set ns=101.101.101.101

set cparsing=%1
set coutput=%2

for /f %%a in (%cparsing%) do (
dog %%a A --edns=disable @%ns% -1 | findstr /v [Aa-Zz] | sed "s/$/ %%a/g" >>%coutput%
dog %%a AAAA --edns=disable @%ns% -1 | findstr /c:":" | sed "s/$/ %%a/g" >>%coutput%
)

del /f /q DD%cparsing%
exit
