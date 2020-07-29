@ECHO OFF
SETLOCAL

SET dotfiles=dotfiles

where git > NUL 2> NUL
IF %ERRORLEVEL%==0 (
	IF NOT EXIST "%dotfiles%" (
		ECHO Cloning dotfiles into "%dotfiles%"
		git clone https://github.com/TerryHughes/dotfiles.git "%dotfiles%" 2> NUL
	)
)
