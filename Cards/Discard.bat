@echo off
setlocal enabledelayedexpansion

::ARGUMENTS
:: 1 - Player number who is discarding - Make this 0 to discard New Card
:: 2 - Card Number they are discarding
:: 3 - Path to .bat files

set /a playerNumber=%~1
set /a cardNumber=%~2
set "gameLog=%~3\gameLog.bat"
call %gameLog%

set /a cardAmount=!player%playerNumber%.cardAmount!

set /a disCounter=%discardPile.totalCards%
set "discardPile=%~3\discardPile.bat"
set /a disCounter+=1
echo set /a discardPile.totalCards+=1 >>%gameLog%
echo. >>%gameLog%

echo Player %playerNumber% is discarding card %cardNumber%.

if %playerNumber%==0 (
    echo set "discard.card%disCounter%.name=!newCard.name!" >>%discardPile%
    echo set "discard.card%disCounter%.id=!newCard.id!" >>%discardPile%
    echo set "discard.card%disCounter%.suit=!newCard.suit!" >>%discardPile%
    echo set /a discard.card%disCounter%.value=!newCard.value! >>%discardPile%
    echo set "discard.card%disCounter%.power=!newCard.power!" >>%discardPile%
    echo. >>%discardPile%
)

if %playerNumber% NEQ 0 (
    echo set "discard.card%disCounter%.name=!player%playerNumber%.card%cardNumber%.name!" >>%discardPile%
    echo set "discard.card%disCounter%.id=!player%playerNumber%.card%cardNumber%.id!" >>%discardPile%
    echo set "discard.card%disCounter%.suit=!player%playerNumber%.card%cardNumber%.suit!" >>%discardPile%
    echo set /a discard.card%disCounter%.value=!player%playerNumber%.card%cardNumber%.value! >>%discardPile%
    echo set "discard.card%disCounter%.power=!player%playerNumber%.card%cardNumber%.power!" >>%discardPile%
    echo. >>%discardPile%
)

if %playerNumber% NEQ 0 (
    echo set "player%playerNumber%.card%cardNumber%.name=!player%playerNumber%.card%cardAmount%.name!" >>%gameLog%
    echo set "player%playerNumber%.card%cardNumber%.id=!player%playerNumber%.card%cardAmount%.id!" >>%gameLog%
    echo set "player%playerNumber%.card%cardNumber%.suit=!player%playerNumber%.card%cardAmount%.suit!" >>%gameLog%
    echo set /a player%playerNumber%.card%cardNumber%.value=!player%playerNumber%.card%cardAmount%.value! >>%gameLog%
    echo set "player%playerNumber%.card%cardNumber%.power=!player%playerNumber%.card%cardAmount%.power!" >>%gameLog%
    echo. >>%gameLog%
    echo set /a player%playerNumber%.cardAmount-=1 >>%gameLog%
)