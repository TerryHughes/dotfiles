@ECHO OFF
SETLOCAL

REM https://superuser.com/questions/160702/get-current-folder-name-by-a-dos-command/160712#160712
FOR %%a IN (.) DO SET Project=%%~nxa

REM http://www.tech-recipes.com/rx/956/windows-batch-file-bat-to-get-current-date-in-mmddyyyy-format
FOR /F "tokens=2-4 delims=/ " %%a IN ('ECHO %DATE%') DO SET FormattedDate=%%c%%a%%b

SET BackupName=%Project%-%FormattedDate%.zip

IF EXIST "data" (
	IF EXIST "C:\Program Files\7-Zip\7z.exe" (
		IF EXIST "U:\" (
			where cloc  > NUL 2>NUL
			IF %ERRORLEVEL%==0 SET clocAvailable=true
			IF DEFINED clocAvailable (
				MKDIR "data\cloc"  2> NUL
				cloc --by-file-by-lang --report-file="data\cloc\%FormattedDate%.txt" --exclude-dir="build","data" --exclude-ext="g.c" . > NUL
			)

			where ctime > NUL 2>NUL
			IF %ERRORLEVEL%==0 SET ctimeAvailable=true
			IF DEFINED ctimeAvailable (
				IF EXIST "data\%Project%.ctm" (
					MKDIR "data\ctime" 2> NUL
					ctime -stats "data\%Project%.ctm" > "data\ctime\%FormattedDate%.txt"
				)
			)

			"C:\Program Files\7-Zip\7z.exe" a -ir!"data" "%BackupName%" > NUL

			MKDIR "U:\DataDirectoryBackups" 2> NUL
			MOVE "%BackupName%" "U:\DataDirectoryBackups\" > NUL
		) ELSE (
			ECHO No backup could be made because the U drive is not defined
		)
	) ELSE (
		ECHO No backup could be made because 7-Zip is not installed
	)
) ELSE (
	ECHO No backup could be made because no data directory exists
)
