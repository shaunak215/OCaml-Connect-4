(*
    initializes a new game with an empty board
    int value determines number of players 1 (against ai) or 2
*)
val new_game : int -> Board.t

(*
    initializes a saved game with that board
    1st int value determines number of players 1 (against ai) or 2
*)
val decode_game : string -> Board.t

(*
    saves the current game state in the form of
    a string int pair representation of the game
    1st int value determines number of players 1 (against ai) or 2
*)
val encode_game : Board.t -> string

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