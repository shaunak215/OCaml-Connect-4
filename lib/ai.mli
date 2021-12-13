(* 
    The Ai takes in the board and a boolean that represents if we are 
    using the real/hard ai or the dumb/random move generator. 
    It then outputs a new board with the move made and an int
    representing which column was inserted into.
*)

val make_move : Board.t -> bool -> Board.t * int

