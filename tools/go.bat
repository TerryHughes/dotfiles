@ECHO OFF

IF EXIST "W:\projects\%1" (
	W:
	CD "\projects\%1"
	GOTO :EOF
)

GOTO %1 2> NUL || (
	ECHO Unknown location '%1'
)

:projects
:proj
:p
	W:
	CD "\projects\"
	GOTO :EOF

:aliases
:a
	W:
	CD "\aliases\"
	GOTO :EOF

:tools
:t
	W:
	CD "\tools\"
	GOTO :EOF

:adventure
:adv
	L:
	CD "\FifthElement\dev\work\projects\adventure\"
	GOTO :EOF

:handmade-hero
:hmh
	L:
	CD "\FifthElement\dev\Handmade Hero\"
	GOTO :EOF
