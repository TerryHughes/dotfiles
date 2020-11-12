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


MKDIR ".config" 2> NUL
IF EXIST "%dotfiles%\configurations\git" (
	IF NOT EXIST ".config\git" (
		ECHO Linking Git configuration
		MKLINK /J ".config\git" "%dotfiles%\configurations\git" > NUL
	)
)


MKDIR "%AppData%\jesseduffield" 2> NUL
IF EXIST "%dotfiles%\configurations\lazygit" (
	IF NOT EXIST "%AppData%\jesseduffield\lazygit" (
		ECHO Linking lazygit configuration
		MKLINK /J "%AppData%\jesseduffield\lazygit" "%dotfiles%\configurations\lazygit" > NUL
	)
)
