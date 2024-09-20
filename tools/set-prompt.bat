@ECHO OFF

where git > NUL 2>NUL
IF %ERRORLEVEL%==0 SET gitAvailable=true
IF NOT DEFINED gitAvailable GOTO normal

SET TopLevel=
FOR /F "tokens=* USEBACKQ" %%L IN (`git --no-optional-locks rev-parse --show-toplevel 2^>NUL`) DO (
	SET TopLevel=%%L
)

IF DEFINED TopLevel (
	SET GitDirectory=%TopLevel%/.git
	IF NOT EXIST "%GitDirectory%/*" (
		FOR /F "tokens=* USEBACKQ" %%L IN (`type "%GitDirectory%"`) DO (
			SET gitdir=true
			FOR %%T IN (%%L) DO (
				IF DEFINED gitdir (
					SET gitdir=
				) ELSE (
					SET GitDirectory=%%T
				)
			)
		)
	)
	SET CommitHash=
	git --no-optional-locks status --porcelain=2 --branch --show-stash > stat
	rem FOR /F "tokens=* USEBACKQ" %%L IN (`git --no-optional-locks status --porcelain=2 --branch --show-stash`) DO (
	FOR /F "tokens=* USEBACKQ" %%L IN (`type stat`) DO (
		FOR %%T IN (%%L) DO (
			rem echo chash %CommitHash%
			IF "%CommitHash%"=="true" (
				rem echo setting commit
				SET CommitHash=%%T
			)

			IF "%%T"=="#" (
				rem echo hash
			) ELSE IF "%%T"=="branch.oid" (
				rem echo commit
			) ELSE (
				rem echo x%%Tx
			)
			IF "%%T"=="branch.oid" (
				rem echo w%%Tw
				SET CommitHash=true
				rem echo chash %CommitHash%
			)
		)
	)
	type stat
	del stat

	echo %GitDirectory%
	echo wip %CommitHash%
	echo need to make better
	SET prompt=$P$SGIT$S$+$_$G$S
	EXIT /B 0
)

:normal
SET prompt=$P$S$+$_$G$S
