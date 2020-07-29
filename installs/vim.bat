@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION

SET DesiredVimMajorVersion=8
SET DesiredVimMinorVersion=2

SET DesiredVimVersion=%DesiredVimMajorVersion%%DesiredVimMinorVersion%
SET DesiredVimExe=gvim%DesiredVimVersion%.exe

PUSHD "%USERPROFILE%\Downloads"
IF NOT EXIST "%DesiredVimExe%" (
	ECHO Downloading "%DesiredVimExe%"
	curl -LJOs "https://ftp.nluug.nl/pub/vim/pc/%DesiredVimExe%"
	IF NOT !ERRORLEVEL!==0 (
		ECHO curl did not complete successfully: !ERRORLEVEL!
		GOTO :exit
	)
)

ECHO Manually run %DesiredVimExe% as administrator
ECHO.
ECHO 	  check 'Create .bat files'
ECHO 	uncheck 'Create icons for Vim\On the Desktop'
explorer .
PAUSE

:exit
POPD
