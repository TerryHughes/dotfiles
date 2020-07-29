@ECHO OFF

SET SetTitle=true
SET DoNotSetTitle=%2
IF DEFINED DoNotSetTitle SET SetTitle=

SET Location=%1

IF EXIST "W:\projects\%Location%" (
	W:
	CD "\projects\%Location%"
	IF DEFINED SetTitle TITLE %Location%
	EXIT /B 0
)

IF %Location%==p SET Location=projects

IF EXIST "W:\%Location%" (
	W:
	CD "\%Location%"
	IF DEFINED SetTitle TITLE %Location%
	EXIT /B 0
)

GOTO %Location% 2> NUL || (
	ECHO Unknown location '%Location%'
)

:adventure
:adv
	L:
	CD "\FifthElement\dev\work\projects\adventure\"
	IF DEFINED SetTitle TITLE adventure
	EXIT /B 0

:handmade-hero
:hmh
	L:
	CD "\FifthElement\dev\Handmade Hero\"
	IF DEFINED SetTitle TITLE hmh
	EXIT /B 0
