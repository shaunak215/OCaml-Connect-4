(*
    initializes a new game with an empty board
    int value determines number of players 1 (against ai) or 2
*)
val new_game : int -> Board.t

(*
    Takes in a string compression of the board and creates a board from taht
*)
val decode_game : string -> Board.t

(*
    initializes a saved game with that board
    1st int value determines number of players 1 (against ai) or 2
    2nd int value is ignored if the number of players is 1, if there 
    are two then it indicates if the player is player 1 or 2
*)
val load_game : string -> int -> int -> Board.t * int * int

(*
    saves the current game state in the form of
    a string int int pair representation of the game
    1st int value determines number of players 1 (against ai) or 2
    2nd int value is a dummy value if the number of players is 1, if there 
    are two then it indicates if the player is player 1 or 2
*)
val save_game : Board.t -> int -> int -> string * int * int

(*
    If move is completed return new board and true
    otherwise return original board and false
*)
val move : Board.t -> int -> Board.t * bool

(*
    TO DO
    currently, will output to command line,
    but will look more into dream and outputting
    to web page
*)
val render : Board.t -> unit