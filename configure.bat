@ECHO OFF
SETLOCAL

SET dotfiles=dotfiles
SET dotfilesExternalTools=dotfiles-externaltools

where git > NUL 2> NUL
IF %ERRORLEVEL%==0 (
	IF NOT EXIST "%dotfiles%" (
		ECHO Cloning dotfiles into "%dotfiles%"
		git clone https://github.com/TerryHughes/dotfiles.git "%dotfiles%" 2> NUL
	)

	IF NOT EXIST "%dotfilesExternalTools%" (
		ECHO Cloning dotfiles-externaltools into "%dotfilesExternalTools%"
		git clone https://github.com/TerryHughes/dotfiles-externaltools.git "%dotfilesExternalTools%" 2> NUL
	)
)
