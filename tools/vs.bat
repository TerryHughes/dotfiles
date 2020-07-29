@ECHO OFF

IF EXIST "miscellaneous\shells\vs2015.bat" CALL "miscellaneous\shells\vs2015.bat"
IF EXIST "vs2015.bat" CALL "vs2015.bat"
where cl > NUL 2> NUL
IF %ERRORLEVEL%==0 GOTO :EOF
