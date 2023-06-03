@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION

SET DesiredWinDirStatMajorVersion=1
SET DesiredWinDirStatMinorVersion=1
SET DesiredWinDirStatRevisionVersion=2

SET DesiredWinDirStatVersion=%DesiredWinDirStatMajorVersion%_%DesiredWinDirStatMinorVersion%_%DesiredWinDirStatRevisionVersion%
SET DesiredWinDirStatExe=windirstat%DesiredWinDirStatVersion%_setup.exe

PUSHD "%USERPROFILE%\Downloads"
IF NOT EXIST "%DesiredWinDirStatExe%" (
	ECHO Downloading "%DesiredWinDirStatExe%"
	"%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe" "https://www.fosshub.com/WinDirStat.html?dwl=%DesiredWinDirStatExe%"
	PAUSE
)

ECHO Installing "%DesiredWinDirStatExe%"
ECHO.
ECHO 	uncheck 'Create shortcut on the desktop'
"%DesiredWinDirStatExe%"
IF NOT !ERRORLEVEL!==0 (
	ECHO WinDirStat did not install successfully: !ERRORLEVEL!
	GOTO :exit
)

:exit
POPD
