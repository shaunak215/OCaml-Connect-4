
(*
    our game will have the type of board
*)
type t

(*
    initializes a new game with an empty board
    int value determines number of players 1 (against ai) or 2
*)
val new_game : int -> t

(*
    initializes a saved game with that board
    int value determines number of players 1 (against ai) or 2
*)
val load_game : string * int -> t

(*
    saves the current game state in the form of
    a string int pair representation of the game
*)
val save_game : t -> string * int

val move : t -> int -> t

(*
    currently, will output to command line,
    but will look more into dream and outputting
    to web page
*)
val render : t -> unit

