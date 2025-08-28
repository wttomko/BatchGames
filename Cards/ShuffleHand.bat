@echo off
setlocal enabledelayedexpansion

::ARGUMENTS
:: 1 - player number 
:: 2 - path to .bat files

set /a playerNumber=%~1
set "path=%~2"
set "gameLog=%~2\gameLog.bat"


call %gameLog%

echo Player %playerNumber% is now shuffling their hand.

set /a ran=%random%
break>%~dp0%ran%AlreadyChosen.txt

set /a maxNum=!player%playerNumber%.cardAmount!

for /l %%a in (1,1,%maxNum%) do call :Shuffle %%a
del %~dp0%ran%AlreadyChosen.txt
call %~dp0RefreshGameLog.bat %path%
exit /b 0



:Shuffle
    set /a c=%~1
:loop

set /a count=%random% %% %maxNum%+1
set /a alreadyChosen=0

if exist %~dp0%ran%AlreadyChosen.txt for /f "delims=" %%a in (%~dp0%ran%AlreadyChosen.txt) do (if "%%a"=="%count%" set /a alreadyChosen=1)
if %alreadyChosen%==1 goto loop
if %alreadyChosen%==0 (
>> %~dp0%ran%AlreadyChosen.txt echo %count%
)

echo set "player%playerNumber%.card%c%.name=!player%playerNumber%.card%count%.name!" >>%gameLog%
echo set "player%playerNumber%.card%c%.id=!player%playerNumber%.card%count%.id!" >>%gameLog%
echo set "player%playerNumber%.card%c%.suit=!player%playerNumber%.card%count%.suit!" >>%gameLog%
echo set /a player%playerNumber%.card%c%.value=!player%playerNumber%.card%count%.value! >>%gameLog%
echo set "p >>%gameLog%layer%playerNumber%.card%c%.power=!player%playerNumber%.card%count%.power!" >>%gameLog%


exit /b 0