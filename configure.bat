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


SET wDrive=w-drive
MKDIR "%wDrive%"\projects 2> NUL

IF EXIST "%dotfiles%\aliases" (
	IF NOT EXIST "%wDrive%\aliases" (
		ECHO Linking aliases
		MKLINK /J "%wDrive%\aliases" "%dotfiles%\aliases" > NUL
		START cmd /C tools\update-user-path.bat "W:\aliases;W:\aliases\git;"
		timeout /T 1 /NOBREAK > NUL
	)
)

IF EXIST "%dotfiles%\shells" (
	IF NOT EXIST "%wDrive%\shells" (
		ECHO Linking shells
		MKLINK /J "%wDrive%\shells" "%dotfiles%\shells" > NUL
	)
)

IF EXIST "%dotfiles%\tools" (
	IF NOT EXIST "%wDrive%\tools" (
		ECHO Linking tools
		MKLINK /J "%wDrive%\tools" "%dotfiles%\tools" > NUL
		START cmd /C tools\update-user-path.bat "W:\tools;"
		timeout /T 1 /NOBREAK > NUL
	)
)

IF EXIST "%dotfilesExternalTools%" (
	IF NOT EXIST "%wDrive%\tools-external" (
		ECHO Linking tools-external
		MKLINK /J "%wDrive%\tools-external" "%dotfilesExternalTools%" > NUL
		START cmd /C tools\update-user-path.bat "W:\tools-external;"
		timeout /T 1 /NOBREAK > NUL
	)
)


IF NOT EXIST "%AppData%\Microsoft\Windows\Start Menu\Programs\Startup\startup.lnk" (
	ECHO Manually create a shortcut for startup script
	explorer "%dotfiles%"
	PAUSE
	MOVE "%dotfiles%\startup* - Shortcut.lnk" "%AppData%\Microsoft\Windows\Start Menu\Programs\Startup\startup.lnk" > NUL
)
CALL "%AppData%\Microsoft\Windows\Start Menu\Programs\Startup\startup.lnk"


IF NOT DEFINED prompt (
	ECHO Setting prompt
	setx prompt $P$S$+$_$G$S > NUL
)


IF EXIST "%dotfiles%\configurations\vimfiles" (
	IF NOT EXIST "vimfiles" (
		ECHO Linking Vim
		MKLINK /J "vimfiles" "%dotfiles%\configurations\vimfiles" > NUL
	)
)
