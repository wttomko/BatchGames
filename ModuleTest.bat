@echo off

break>TestFolder\gameLog.bat
echo @echo off >> TestFolder\gameLog.bat
echo. >> TestFolder\gameLog.bat

call Cards\CreateDeck.bat Normal TestFolder
call Cards\Deal.bat 2 3 TestFolder
call Cards\DisplayHand.bat 1 Name TestFolder
call Cards\ShuffleHand.bat 1 TestFolder
call Cards\DisplayHand.bat 1 Name TestFolder
