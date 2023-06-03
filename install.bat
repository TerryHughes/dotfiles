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

IF NOT EXIST "%ProgramFiles(x86)%\Microsoft Visual Studio\2022\BuildTools\VC\Auxiliary\Build\vcvarsall.bat" (
	CALL "installs\microsoft-build-tools-2022.bat"
)

IF NOT EXIST "%ProgramFiles%\Google\Chrome" (
	CALL "installs\chrome.bat"
)

IF NOT EXIST "%ProgramFiles%\7-Zip" (
	CALL "installs\7-zip.bat"
)

IF NOT EXIST "%ProgramFiles%\Everything" (
	CALL "installs\everything.bat"
)

IF NOT EXIST "%ProgramFiles(x86)%\WinDirStat" (
	CALL "installs\windirstat.bat"
)

EXIT 0
