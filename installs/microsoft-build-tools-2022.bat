@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION

SET BuildToolsExe=vs_BuildTools.exe

PUSHD "%USERPROFILE%\Downloads"
IF NOT EXIST "%BuildToolsExe%" (
	ECHO Downloading "%BuildToolsExe%"
	curl -LJOs "https://aka.ms/vs/17/release/%BuildToolsExe%"
	IF NOT !ERRORLEVEL!==0 (
		ECHO curl did not complete successfully: !ERRORLEVEL!
		GOTO :exit
	)
)

ECHO Installing "%BuildToolsExe%" (this will take a while)
"%BuildToolsExe%" --add Microsoft.VisualStudio.Component.Windows10SDK.18362 --add Microsoft.VisualStudio.Component.VC.Tools.x86.x64 --quiet --wait
IF NOT !ERRORLEVEL!==0 (
	ECHO Microsoft Build Tools 2022 did not install successfully: !ERRORLEVEL!
	GOTO :exit
)

:exit
POPD
