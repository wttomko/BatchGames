@echo off
setlocal enabledelayedexpansion

::Deck will be writting to a deck.bat file in the following format...

:: set "card1.name=********"
:: set "card1.id=******"
:: set "card1.suit=******"
:: set /a card1.value=******"
:: set "card1.power=******"

::Arguements Below (BOTH REQUIRED)
::1 - Modifier (Currently have Normal, War, Golf, Battle)
::2 - Path to folder for the deck to be installed

set "mod=%~1"
set "path=%~2"

set "deckLog=%path%\deck.bat"
set "discardPile=%path%\discardPile.bat"

set /a jokerCounter=0
set /a blankCounter=0

if /i "%mod%"=="Normal" (
	set /a maxNum=52
)

if /i "%mod%"=="War" (
	set /a maxNum=52
)

if /i "%mod%"=="Golf" (
	set /a maxNum=55
)

if /i "%mod%"=="Battle" (
	set /a maxNum=54
)

::CREATE ALL THE FILES, ONE TEMPORARY FILE FOR THE 'SHUFFLE' MODULE

set /a ran=%random%
break>%path%\%ran%alreadyChosen.txt
break>%deckLog%
break>%discardPile%

echo @echo off >>%deckLog%
echo @echo off >>%discardPile%

echo. >>%discardPile%
echo. >>%deckLog%

cls

::DISPLAY FOR THE USER-SHOWS THE CHOSEN MODIFIER AND NUMBER OF CARDS

echo ========================
echo Shuffling Cards
echo.
echo Game Mode^: %mod%
echo Amount of Cards^: %maxNum%
echo ========================

::START OF CARD ASSEMBLE - LOOP THROUGH SUITS, THEN IDS

for %%a in (Hearts Clubs Spades Diamonds) do call :Create "%%a"
echo set /a discardPile.totalCards=0 >>%path%\gameLog.bat
echo set /a deck.totalCards=%maxNum% >>%path%\gameLog.bat
del %path%\%ran%alreadyChosen.txt


::WITH ALL VARIABLES CREATED, ECHO TO deck.bat FILE

for /l %%a in (1,1,%maxNum%) do (

	echo set "card%%a.name=!card%%a.name!" >>%deckLog%
	echo set "card%%a.id=!card%%a.id!" >>%deckLog%
	echo set "card%%a.suit=!card%%a.suit!" >>%deckLog%
	echo set /a card%%a.value=!card%%a.value! >>%deckLog%
	echo set "card%%a.power=!card%%a.power!" >>%deckLog%
	echo. >>%deckLog%

)
::END
cls
exit /b 0

:Create
set suitArg=%~1
goto %mod%

::SOME MODIFIERS INCLUDE JOKERS AND A BLANK CARD

:Normal
for %%b in (2 3 4 5 6 7 8 9 Ten Jack Queen King Ace) do call :Combine "%%b"
exit /b 0

:Golf 
for %%b in (2 3 4 5 6 7 8 9 Ten Jack Queen King Ace Joker Blank) do call :Combine "%%b"
exit /b 0

:Battle
for %%b in (2 3 4 5 6 7 8 9 Ten Jack Queen King Ace Joker) do call :Combine "%%b"
exit /b 0

:War
for %%b in (2 3 4 5 6 7 8 9 Ten Jack Queen King Ace) do call :Combine "%%b"
exit /b 0

:Combine
set id=%~1

::IF LOOP ITERATION IS ON JOKER OR BLANK, CHECK TO ENSURE THERE ARE ONLY 2 JOKERS AND 1 BLANK

if "%id%"=="Joker" goto JokerCheck
if "%id%"=="Blank" goto BlankCheck

goto loop

:JokerCheck
	set /a jokerCounter+=1
	if "%jokerCounter%" GTR "2" goto EndCombine
goto loop

:BlankCheck
	set /a blankCounter+=1
	if "%blankCounter%" GTR "1" goto EndCombine
goto loop

:loop

::SHUFFLE MODULE. ECHO RANDOM NUMBER BETWEEN 1 AND MAX AMOUNT IN DECK TO TXT FILE IF NOT EXIST. DOES NOT SEEM MOST EFFECIENT BUT WORKS WELL?!

set /a count=%random% %% %maxNum%+1
set /a alreadyChosen=0

if exist %path%\%ran%alreadyChosen.txt for /f "delims=" %%a in (%path%\%ran%alreadyChosen.txt) do (if "%%a"=="%count%" set /a alreadyChosen=1)
if %alreadyChosen%==1 goto loop
if %alreadyChosen%==0 (
>> %path%\%ran%alreadyChosen.txt echo %count%
)

if "%id%"=="Joker" (
	call :AddJoker
	goto EndCombine
)
if "%id%"=="Blank" (
	call :AddBlank
	goto EndCombine
)

 set "card%count%.name=!id!_of_!suitArg!" 
 set "card%count%.id=!id!" 
 set "card%count%.suit=!suitArg!" 

goto %mod%_Combine

 ::MODIFIERS BELOW ADD VALUES AND POWERS TO EACH CARD DEPENDENT ON ID

:War_Combine
:Normal_Combine

	if !id!==2 set /a card%count%.value=2 && set "card%count%.power=n/a"
	if !id!==3 set /a card%count%.value=3 && set "card%count%.power=n/a"
	if !id!==4 set /a card%count%.value=4 && set "card%count%.power=n/a" 
	if !id!==5 set /a card%count%.value=5 && set "card%count%.power=n/a" 
	if !id!==6 set /a card%count%.value=6 && set "card%count%.power=n/a" 
	if !id!==7 set /a card%count%.value=7 && set "card%count%.power=n/a" 
	if !id!==8 set /a card%count%.value=8 && set "card%count%.power=n/a" 
	if !id!==9 set /a card%count%.value=9 && set "card%count%.power=n/a" 
	if !id!==Ten set /a card%count%.value=10 && set "card%count%.power=n/a" 
	if !id!==Jack set /a card%count%.value=10 && set "card%count%.power=n/a" 
	if !id!==Queen set /a card%count%.value=10 && set "card%count%.power=n/a" 
	if !id!==King set /a card%count%.value=10 && set "card%count%.power=n/a" 
	if !id!==Ace set /a card%count%.value=11 && set "card%count%.power=n/a" 

goto EndCombine

:Golf_Combine

	if !id!==2 set /a card%count%.value=-2  && set "card%count%.power=n/a" 
	if !id!==3 set /a card%count%.value=3  && set "card%count%.power=n/a" 
	if !id!==4 set /a card%count%.value=4  && set "card%count%.power=n/a" 
	if !id!==5 set /a card%count%.value=5  && set "card%count%.power=n/a" 
	if !id!==6 set /a card%count%.value=6  && set "card%count%.power=n/a" 
	if !id!==7 set /a card%count%.value=7  && set "card%count%.power=n/a" 
	if !id!==8 set /a card%count%.value=8  && set "card%count%.power=n/a" 
	if !id!==9 set /a card%count%.value=9  && set "card%count%.power=n/a" 
	if !id!==Ten set /a card%count%.value=10  && set "card%count%.power=n/a" 
	if !id!==Jack set /a card%count%.value=10  && set "card%count%.power=peek" 
	if !id!==Queen set /a card%count%.value=10  && set "card%count%.power=swap" 
	if !id!==King set /a card%count%.value=0  && set "card%count%.power=n/a" 
	if !id!==Ace set /a card%count%.value=1  && set "card%count%.power=n/a" 

goto EndCombine

:Battle_Combine

	if !id!==2 set /a card%count%.value=-2  && set "card%count%.power=n/a" 
	if !id!==3 set /a card%count%.value=3  && set "card%count%.power=n/a" 
	if !id!==4 set /a card%count%.value=4  && set "card%count%.power=n/a" 
	if !id!==5 set /a card%count%.value=5  && set "card%count%.power=n/a" 
	if !id!==6 set /a card%count%.value=6  && set "card%count%.power=n/a" 
	if !id!==7 set /a card%count%.value=7  && set "card%count%.power=n/a" 
	if !id!==8 set /a card%count%.value=8  && set "card%count%.power=n/a" 
	if !id!==9 set /a card%count%.value=9  && set "card%count%.power=n/a" 
	if !id!==Ten set /a card%count%.value=10  && set "card%count%.power=n/a" 
	if !id!==Jack set /a card%count%.value=10  && set "card%count%.power=counter" 
	if !id!==Queen set /a card%count%.value=10  && set "card%count%.power=defense" 
	if !id!==King set /a card%count%.value=0  && set "card%count%.power=attack" 
	if !id!==Ace set /a card%count%.value=1  && set "card%count%.power=endurance" 

goto EndCombine

:EndCombine
exit /b 0

::FUNCTIONS //////////////////////////////////////////////////////////////////

:AddJoker

	set "card%count%.name=!id!" 
	set "card%count%.id=!id!" 
	set "card%count%.suit=!id!" 
	set /a card%count%.value=0 
	if /i "%mod%"=="Golf" set "card%count%.power=Shuffle" 
	if /i "%mod%"=="Battle" set "card%count%.power=extra" 

exit /b 0

:AddBlank

	set "card%count%.name=!id!" 
	set "card%count%.id=!id!" 
	set "card%count%.suit=!id!" 
	set /a card%count%.value=0 
	if /i "%mod%"=="Golf" set "card%count%.power=EndGame" 

exit /b 0
