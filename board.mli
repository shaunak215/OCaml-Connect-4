
(* 
    This is the representation of a player, 
    It will be used for marking spots and determining whose turn it is
*)
type player = P1 | P2 | Empty

(*
    This is the type of the board
    In the actual implementation we plan to use a player list list
*)
type t

(*
    This will be value which indicates whose turn it is
*)
type turn = player

val init : t

val cur_player : player

val cur_board : t

val is_valid_move : int -> t -> bool

val insert_piece : int -> t -> t

val game_over : t -> bool * player