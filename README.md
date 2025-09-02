# Batch Games

## All Modules and their arguments/functions

    ** gameLog.bat must already be created before calling these scripts **
    ** all instances of 'path to .bat files' do not include the forward slash \ **


    -- Create Deck .bat -------------------------------------------------------------
    ---------------------------------------------------------------------------------

        Arguments
            1. Modifer (Normal, Golf, War, Battle)
            2. Path to where all the core .bat files should be installed

        Function
            Creates a 'deck.bat' and 'discardPile.bat'
            Script will create all cards with 5 attributes...
                1. name
                2. id
                3. suit
                4. value
                5. power

            Example of one card:
                "card1.name=2_of_Spades" 
                "card1.id=2" 
                "card1.suit=Spades" 
                card1.value=2 
                "card1.power=n/a" 

            Deck is shuffled, then all cards are written to deck.bat
            discardPile is empty

            2 variables are created in the gameLog.bat file
                1. deck.totalCards
                2. discardPile.totalCards

    -- Deal .bat ---------------------------------------------------------------------
    ----------------------------------------------------------------------------------
        Arguments
            1. Amount of players
            2. Amount of cards to each player
            3. Path to the .bat files

        Function
            Reads the deck.bat file, then deals X amount of cards to Y amount of players
            Writes the results to the gameLog
            Creates a 'deck counter' to know where to draw from the deck -writes to gameLog

        *potential update.. have the deck counter be created outside this script, to potential deal mid game? the script now sets the deck counter to 0 **

    -- Discard .bat ------------------------------------------------------------------
    ----------------------------------------------------------------------------------
        Arguments
            1. Number of the player that is discarding
            2. Card number they are discarding
            3. Path to .bat files

        Function
            Remove the chosen card from the player and add it to the discard pile
            Additionally, take the last card in the players hand, and have that card 
            take the place of the chosen card (to ensure that player X's card #Y is not null)

    -- Display