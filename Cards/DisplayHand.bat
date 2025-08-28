@echo off
setlocal enabledelayedexpansion

::Arguments
::1 Player num
::2 Style - Name, Short
::3 Path to .bat files

set /a player=%~1 
set "style=%~2"
set "gameLog=%~3\gameLog.bat"
call %gameLog%
set /a total=!player%player%.cardAmount!

if /i "%style%"=="Name" (
    for /l %%a in (1,1,%total%) do echo [%%a] !player%player%.card%%a.name!
)

if /i "%style%"=="Short" (
    for /l %%a in (1,2,%total%) do call :short %%a
)

exit /b 0

:Short
set /a y=%~1
set /a x=y+1
echo [%y%] !player%player%.card%y%.id:~0,1!!player%player%.card%y%.suit:~0,1!     [%x%] !player%player%.card%x%.id:~0,1!!player%player%.card%x%.suit:~0,1!
exit /b 0