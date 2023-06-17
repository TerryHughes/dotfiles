@ECHO OFF
SETLOCAL

FOR /F "tokens=3" %%A IN ('reg QUERY "HKCU\Environment" /v "Path"') DO SET CurrentUserPath=%%A
SET CurrentUserPath=%CurrentUserPath%%1
setx Path %CurrentUserPath% > NUL
