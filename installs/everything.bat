@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION

SET DesiredEverythingMajorVersion=1
SET DesiredEverythingMinorVersion=4
SET DesiredEverythingRevisionVersion=1
SET DesiredEverythingBuildVersion=1023

SET DesiredEverythingVersion=%DesiredEverythingMajorVersion%.%DesiredEverythingMinorVersion%.%DesiredEverythingRevisionVersion%.%DesiredEverythingBuildVersion%
SET DesiredEverythingExe=Everything-%DesiredEverythingVersion%.x64-Setup.exe

PUSHD "%USERPROFILE%\Downloads"
IF NOT EXIST "%DesiredEverythingExe%" (
	ECHO Downloading "%DesiredEverythingExe%"
	curl -LJOs "https://www.voidtools.com/%DesiredEverythingExe%"
	IF NOT !ERRORLEVEL!==0 (
		ECHO curl did not complete successfully: !ERRORLEVEL!
		GOTO :exit
	)
)

ECHO Installing "%DesiredEverythingExe%"
ECHO.
ECHO 	uncheck 'Install Desktop shortcut'
"%DesiredEverythingExe%"
IF NOT !ERRORLEVEL!==0 (
	ECHO Everything did not install successfully: !ERRORLEVEL!
	GOTO :exit
)

ECHO.
ECHO 	Tools->Options
ECHO 	  General\UI
ECHO 	    uncheck 'Show tray icon'
ECHO 	  General\Keyboard
ECHO 	    set 'New window hotkey' to Alt+Shift+E
PAUSE

:exit
POPD
