
(*
    initializes a new game with an empty board
    int value determines number of players 1 (against ai) or 2
*)
val new_game : int -> Board.t

(*
    initializes a saved game with that board
    int value determines number of players 1 (against ai) or 2
*)
val load_game : string * int -> Board.t

(*
    saves the current game state in the form of
    a string int pair representation of the game
*)
val save_game : Board.t -> string * int

(*
    TO DO
*)
val move : Board.t -> int -> t

(*
    TO DO
    currently, will output to command line,
    but will look more into dream and outputting
    to web page
*)
val render : Board.t -> unit

val pll_to_arr : Board.player list list -> array

val arr_to_pll : array -> Board.player list list