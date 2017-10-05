@echo off
set arg1=%1
shift
:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
	echo  %~1
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%USERPROFILE%\bash-as-admin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%USERPROFILE%\bash-as-admin.vbs"

    "%USERPROFILE%\bash-as-admin.vbs"
    exit /B

:gotAdmin
    if exist "%USERPROFILE%\bash-as-admin.vbs" ( del "%USERPROFILE%\bash-as-admin.vbs" )
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------

call %arg1%