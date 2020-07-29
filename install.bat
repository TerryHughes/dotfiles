@ECHO OFF
SETLOCAL

where git > NUL 2> NUL
IF NOT %ERRORLEVEL%==0 (
	CALL "installs\git.bat"
)

EXIT 0
