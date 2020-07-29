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
