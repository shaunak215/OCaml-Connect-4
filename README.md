Connect 4!!

To run the Connect 4 server and play our implementation of the game:
1. run 'dune build' in the directory
2. run 'opam install .' as well to download all the dependencies needed (you may have to rerun 'dune build' after installing the dependencies)
3. lastly, run 'dune exec ./src/server.exe' to start up the server and go to http://localhost:8080 to interact with the webpage

Once on the webpage, you begin by selecting the number of players that you want to play the game with or you can load an existing game that you have already saved before.
1 player -> In 1 player mode, you play against an AI. There are two levels of difficulty: Easy and Hard. Easy is really easy and Hard is really hard. You also select whether you want to go first or second.
2 player -> In 2 player mode, the webpage allows for two people two play each other. Red goes first.

Saving a game -> At any point during a game, regardless of 1 or 2 player mode, you can choose to save the game. This will save the game to your system.
Loading a game -> To load the game that you saved, hit load game on the beginning screen and it will resume play of the saved game that you previously saved.

Gameplay -> 
Once in a game, when your turn is prompted, you simply click the "Go Here" button which corresponds to the column that you'd like to play in.
The server will then make that move for you and update the game as needed. This continues until a player wins or a tie is reached.

Reset -> To go back to the home page to start a new game or load a game, simply click the reset button to do so