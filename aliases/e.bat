@ECHO OFF
SETLOCAL

SET Argument=%*
IF NOT DEFINED Argument SET Argument=.

explorer %Argument%
