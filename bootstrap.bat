@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION

SET DesiredGitVersion=2.29.2
SET DesiredGitExe=Git-%DesiredGitVersion%.3-64-bit.exe

where git > NUL 2> NUL
IF NOT %ERRORLEVEL%==0 (
	CD "%USERPROFILE%\Downloads"
	IF NOT EXIST "%DesiredGitExe%" (
		curl -LJO "https://github.com/git-for-windows/git/releases/download/v%DesiredGitVersion%.windows.3/%DesiredGitExe%"
		IF NOT !ERRORLEVEL!==0 (
			ECHO curl did not complete successfully: !ERRORLEVEL!
			GOTO :EOF
		)
	)
	"%DesiredGitExe%" /SILENT
	IF NOT !ERRORLEVEL!==0 (
		ECHO git did not install successfully: !ERRORLEVEL!
		GOTO :EOF
	)
)

EXIT 0
