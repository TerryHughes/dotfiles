@ECHO OFF
SETLOCAL

SET dotfiles=dotfiles
SET dotfilesExternalTools=dotfiles-externaltools

where git > NUL 2> NUL
IF %ERRORLEVEL%==0 (
	IF NOT EXIST "%dotfiles%" (
		git clone https://github.com/TerryHughes/dotfiles.git "%dotfiles%" 2> NUL
	)
	IF NOT EXIST "%dotfilesExternalTools%" (
		git clone https://github.com/TerryHughes/dotfiles-externaltools.git "%dotfilesExternalTools%" 2> NUL
	)
)


MKDIR ".config\git" 2> NUL
IF EXIST "%dotfiles%\configurations\git" (
	IF NOT EXIST ".config\git" (
		MKLINK /J ".config\git" "%dotfiles%\configurations\git" > NUL
	)
)

MKDIR "%AppData%\jesseduffield" 2> NUL
IF EXIST "%dotfiles%\configurations\lazygit" (
	IF NOT EXIST "%AppData%\jesseduffield\lazygit" (
		MKLINK /J "%AppData%\jesseduffield\lazygit" "%dotfiles%\configurations\lazygit" > NUL
	)
)


SET wDrive=w-drive

MKDIR "%wDrive%" 2> NUL

IF EXIST "%dotfiles%\aliases" (
	IF NOT EXIST "%wDrive%\aliases" (
		MKLINK /J "%wDrive%\aliases" "%dotfiles%\aliases" > NUL
	)
)

IF EXIST "%dotfiles%\tools" (
	IF NOT EXIST "%wDrive%\tools" (
		MKLINK /J "%wDrive%\tools" "%dotfiles%\tools" > NUL
	)
)

IF EXIST "%dotfilesExternalTools%" (
	IF NOT EXIST "%wDrive%\tools-external" (
		MKLINK /J "%wDrive%\tools-external" "%dotfilesExternalTools%" > NUL
	)
)

IF NOT EXIST "%AppData%\Microsoft\Windows\Start Menu\Programs\Startup\startup.bat" (
	MKLINK /H "%AppData%\Microsoft\Windows\Start Menu\Programs\Startup\startup.bat" "%dotfiles%\startup.bat" > NUL
)

SET TemporaryPath=%Path%

SET TemporaryPathFile=path.txt
ECHO %TemporaryPath% > "%TemporaryPathFile%"

FOR /F %%A IN ('findstr /L /S /I /N /C:"W:\aliases;" "%TemporaryPathFile%"') DO SET FoundAliases=true
IF NOT DEFINED FoundAliases SET TemporaryPath=%TemporaryPath%W:\aliases;

FOR /F %%A IN ('findstr /L /S /I /N /C:"W:\aliases\git;" "%TemporaryPathFile%"') DO SET FoundAliasesGit=true
IF NOT DEFINED FoundAliasesGit SET TemporaryPath=%TemporaryPath%W:\aliases\git;

FOR /F %%A IN ('findstr /L /S /I /N /C:"W:\tools;" "%TemporaryPathFile%"') DO SET FoundTools=true
IF NOT DEFINED FoundTools SET TemporaryPath=%TemporaryPath%W:\tools;

FOR /F %%A IN ('findstr /L /S /I /N /C:"W:\tools-external;" "%TemporaryPathFile%"') DO SET FoundToolsExternal=true
IF NOT DEFINED FoundToolsExternal SET TemporaryPath=%TemporaryPath%W:\tools-external;

DEL "%TemporaryPathFile%"

setx Path "%TemporaryPath%" > NUL
