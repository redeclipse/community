@echo off
setlocal enabledelayedexpansion
@setlocal enableextensions
@cd /d "%~dp0"

echo This file must be from the bin folder as an Administrator.
echo Updating Red Eclipse version in the registry...

rem ==============================

set count=4
for /f "tokens=3" %%a in (..\src\version.h) do (
	if !count! GTR 0 (
		set /A count-=1
		echo %%a
		set RE_VERSION=%%a
		set RE_VERSION=!RE_VERSION:"=!
	)
)
reg query "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Red Eclipse" /v DisplayVersion
	IF NOT ERRORLEVEL 1 (
		reg add "HKLM\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Red Eclipse" /f /v "DisplayVersion" /t REG_SZ /d %RE_VERSION%
	) ELSE (
		reg query "HKLM\Software\Microsoft\Windows\CurrentVersion\Uninstall\Red Eclipse" /v DisplayVersion
			IF NOT ERRORLEVEL 1 (
				reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Uninstall\Red Eclipse" /f /v DisplayVersion /t REG_SZ /d %RE_VERSION%
			) ELSE (
				echo Uninstall information not found.
			)
	)

pause