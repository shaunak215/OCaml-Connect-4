[@@@ocaml.warning "-27"]

open Board
open Core

let new_game (p : int) : Board.t = assert false

let load_game (game : string * int) : Board.t = assert false

let save_game (board : Board.t) : string * int = assert false

let move (board : Board.t) (col : int) : Board.t * bool =
  if is_valid_move col board then (insert_piece col board, true)
  else (board, false)

let print_list (l : player list) : unit =
  List.iter l ~f:(fun el -> printf "%s " (to_string el));
  print_string "\n"

let get_row (row : int) (b : player list list) : player list =
  List.rev
  @@ List.fold b ~init:[] ~f:(fun init l ->
         match List.nth l row with Some p -> p :: init | None -> Empty :: init)

let render (board : Board.t) : unit =
  let b, _ = board in
  List.iter [ 5; 4; 3; 2; 1; 0 ] ~f:(fun el -> print_list @@ get_row el b)

let pll_to_arr (p : Board.player list list) : string array = assert false

let arr_to_pll (ar : string array) : Board.player list list = assert false
