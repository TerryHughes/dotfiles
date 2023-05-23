@ECHO OFF
SETLOCAL

where git > NUL 2> NUL
IF NOT %ERRORLEVEL%==0 (
	CALL "installs\git.bat"
)

where gvim > NUL 2> NUL
IF NOT %ERRORLEVEL%==0 (
	CALL "installs\vim.bat"
)

IF NOT EXIST "%ProgramFiles(x86)%\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" (
	CALL "installs\microsoft-build-tools-2015-update-3.bat"
)

EXIT 0
