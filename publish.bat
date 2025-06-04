@echo off
cls

REM Variables
set year=%date:~10,4%
set day=%date:~4,2%
set month=%date:~7,2%
set hr=%time:~0,2%
set mn=%time:~3,2%
REM Fix Hours
SET hr=%hr: =0%

set VER=%year%.%month%.%day%.%hr%%mn%
echo %VER%

REM Building
rmdir /q /s publish
mkdir publish
rmdir /q /s package
mkdir package

REM Clean
echo Clean
dotnet clean "FastColoredTextBox.sln"

REM Build
echo Pack Lib
dotnet pack "FastColoredTextBox\FastColoredTextBox.csproj" --interactive --output ".\package" /p:Version=%VER%

REM Upload
echo Upload
dotnet nuget push --source "https://api.nuget.org/v3/index.json" --interactive --api-key oy2py4uamxpaev2iwdwqyp4gfe3jcnguji2zrvd5yr26jq .\package\Fungusware-FCTB.*.nupkg

GOTO _EXIT_

:_FAILURE_
echo ******* Errors occured. See previous.
GOTO _EXIT_




: _EXIT_
pause