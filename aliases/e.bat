@ECHO OFF
SETLOCAL

SET Arguments=%*
IF NOT DEFINED Arguments SET Arguments=.

explorer %Arguments%
