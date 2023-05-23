@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION

SET Desired7ZipMajorVersion=22
SET Desired7ZipMinorVersion=01

SET DEsired7ZipVersion=%Desired7ZipMajorVersion%%Desired7ZipMinorVersion%
SET Desired7ZipExe=7z%Desired7ZipVersion%-x64.exe

PUSHD "%USERPROFILE%\Downloads"
IF NOT EXIST "%Desired7ZipExe%" (
	ECHO Downloading "%Desired7ZipExe%"
	curl -LJOs "https://www.7-zip.org/a/%Desired7ZipExe%"
	IF NOT !ERRORLEVEL!==0 (
		ECHO curl did not complete successfully: !ERRORLEVEL!
		GOTO :exit
	)
)

ECHO Installing "%Desired7ZipExe%"
"%Desired7ZipExe%"
IF NOT !ERRORLEVEL!==0 (
	ECHO 7-Zip did not install successfully: !ERRORLEVEL!
	GOTO :exit
)

:exit
POPD
