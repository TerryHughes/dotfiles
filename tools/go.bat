@ECHO OFF

SET SetTitle=true
SET DoNotSetTitle=%2
IF DEFINED DoNotSetTitle SET SetTitle=

SET Location=%1

GOTO %Location% 2> NUL || (
	ECHO Unknown location '%Location%'
)
