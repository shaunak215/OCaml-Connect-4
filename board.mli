
(* 
    This is the representation of a player, 
    It will be used for marking spots and determining whose turn it is
*)
type player = P1 | P2 | Empty

(*
    This is the type of the board
    In the actual implementation we plan to use a player list list
*)
type t = player list list * player

val init : t

val is_valid_move : int -> t -> bool

(*
    Will be called after verifying a valid move with is_valid_move 
*)
val insert_piece : int -> t -> t

(*
    Given the most recent col which a move was made in and a board
    Return if the game is over and who won
    If not over -> false, Empty
    If tie -> true, Empty
    If player win -> true, player
*)
val game_over : int -> t -> bool * player