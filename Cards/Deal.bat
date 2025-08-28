@echo off
setlocal enabledelayedexpansion

::Arguments
:: 1 Amount of players
:: 2 Amount of cards to each player
:: 3 Path to .Bat files

set /a playerAmount=%~1
set /a cardAmount=%~2

set "deck=%~3\deck.bat"
set "log=%~3\gameLog.bat"

echo Now dealing %cardAmount% card^(s^) to %playerAmount% player^(s^)

call %deck%
set /a deckCounter=0

for /l %%a in (1,1,%cardAmount%) do call :ToPlayer %%a
for /l %%a in (1,1,%playerAmount%) do echo set /a player%%a.cardAmount=%cardAmount% >>%log%

echo set /a deckCounter=%deckCounter% >>%log%
echo set /a totalPlayers=%playerAmount% >>%log%
echo. >>%log%
exit /b 0

:ToPlayer
    set c=%~1
    for /l %%b in (1,1,%playerAmount%) do call :DealCard %%b
exit /b 0

:DealCard
    set p=%~1
    set /a deckCounter+=1
    echo set "player%p%.card%c%.name=!card%deckCounter%.name!" >>%log%
    echo set "player%p%.card%c%.id=!card%deckCounter%.id!" >>%log%
    echo set "player%p%.card%c%.suit=!card%deckCounter%.suit!" >>%log%
    echo set /a player%p%.card%c%.value=!card%deckCounter%.value! >>%log%
    echo set "player%p%.card%c%.power=!card%deckCounter%.power!" >>%log%
    echo. >>%log%
exit /b 0