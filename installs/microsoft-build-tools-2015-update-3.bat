@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION

SET BuildToolsExe=visualcppbuildtools_full.exe

PUSHD "%USERPROFILE%\Downloads"
IF NOT EXIST "%BuildToolsExe%" (
	ECHO Downloading "%BuildToolsExe%"
	curl -LJOs "https://download.microsoft.com/download/5/F/7/5F7ACAEB-8363-451F-9425-68A90F98B238/%BuildToolsExe%"
	IF NOT !ERRORLEVEL!==0 (
		ECHO curl did not complete successfully: !ERRORLEVEL!
		GOTO :exit
	)
)

ECHO Installing "%BuildToolsExe%"
"%BuildToolsExe%" /Passive
IF NOT !ERRORLEVEL!==0 (
	ECHO Microsoft Build Tools 2015 Update 3 did not install successfully: !ERRORLEVEL!
	GOTO :exit
)

:exit
POPD
