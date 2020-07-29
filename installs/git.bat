@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION

SET DesiredGitMajorVersion=2
SET DesiredGitMinorVersion=29
SET DesiredGitRevisionVersion=2
SET DesiredGitVersionRelease=3

SET DesiredGitVersion=%DesiredGitMajorVersion%.%DesiredGitMinorVersion%.%DesiredGitRevisionVersion%
SET DesiredGitExe=Git-%DesiredGitVersion%
IF NOT %DesiredGitVersionRelease%==1 (
	SET DesiredGitExe=%DesiredGitExe%.%DesiredGitVersionRelease%
)
SET DesiredGitExe=%DesiredGitExe%-64-bit.exe

PUSHD "%USERPROFILE%\Downloads"
IF NOT EXIST "%DesiredGitExe%" (
	ECHO Downloading "%DesiredGitExe%"
	curl -LJOs "https://github.com/git-for-windows/git/releases/download/v%DesiredGitVersion%.windows.%DesiredGitVersionRelease%/%DesiredGitExe%"
	IF NOT !ERRORLEVEL!==0 (
		ECHO curl did not complete successfully: !ERRORLEVEL!
		GOTO :exit
	)
)

ECHO Installing "%DesiredGitExe%"
"%DesiredGitExe%" /SILENT
IF !ERRORLEVEL!==0 (
	START cmd /C ..\tools\update-user-path.bat ";"
	timeout /T 1 /NOBREAK > NUL
) ELSE (
	ECHO git did not install successfully: !ERRORLEVEL!
	GOTO :exit
)

:exit
POPD
