@echo off

echo = = = = = = = = = = = = = = = = = = = = = = = = =
echo This file must be from the bin folder.
echo You are about to repair and redownload Red Eclipse
echo This may take a long time and requires a stable internet connection
echo This action will require Administrator access, please run this file as an admin.
set AREYOUSURE=N
set /P AREYOUSURE=Are you sure you wish to proceed? (Y/[N])
IF /I "%AREYOUSURE%" NEQ "Y" GOTO END

echo Removing version markers...
    del version.txt
    del ..\branch.txt
    del ..\version.txt

for /f "tokens=3* delims= " %%a in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v "Personal"') do set REDECLIPSE_WINDOCS=%%a
if EXIST "%REDECLIPSE_WINDOCS%" (
        set REDECLIPSE_CACHE=%REDECLIPSE_WINDOCS%\My Games\Red Eclipse\cache
    ) else if EXIST "%REDECLIPSE_HOME%" (
        set REDECLIPSE_CACHE=%REDECLIPSE_HOME%\cache
    ) else (
        set REDECLIPSE_CACHE=cache
    )

echo Removing cached updates...
    rmdir /S "%REDECLIPSE_CACHE%"

if NOT exist version.txt (
        echo Removal finished. Switching to update.bat script.
        call update.bat
        echo Update finished.
    ) ELSE (
        echo WARNING
        set UPDATEGO=N
        set /P UPDATEGO=Removal was not successful. Would you like to try to update anyways? (Y/[N])
        IF /I "%UPDATEGO%" NEQ "Y" GOTO END
        call update.bat
        echo Update finished.
    )

:END
pause