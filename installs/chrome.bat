@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION

SET DesiredChromeExe=ChromeSetup.exe

PUSHD "%USERPROFILE%\Downloads"
IF NOT EXIST "%DesiredChromeExe%" (
	ECHO Manually download "%DesiredChromeExe%"
	"%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe" "https://www.google.com/chrome/"
	PAUSE
)

ECHO Installing "%DesiredChromeExe%"
"%DesiredChromeExe%"
IF NOT !ERRORLEVEL!==0 (
	ECHO Chrome did not install successfully: !ERRORLEVEL!
	GOTO :exit
)

:exit
POPD
