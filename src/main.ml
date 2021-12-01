open Core
open Connect4

[@@@ocaml.warning "-27"]

(*
   While not end of game
     Print out board
     Ask for a column
     if valid column and move output the new board
     if not valid then output prompt for a new column with error message that invalid column
*)
let rec play_game (b : Board.t) (last_col : int) =
  match Board.game_over last_col b with
  | true, Board.Empty -> print_string "The game ended in a tie!"
  | true, Board.P1 -> print_string "P1 Won!"
  | true, Board.P2 -> print_string "P2 Won!"
  | false, _ -> (
      Game.render b;
      print_string "Enter a column you wish to insert in";
      Out_channel.flush stdout;
      try
        let str = Option.value_exn (In_channel.input_line In_channel.stdin) in let col = int_of_string str in let (new_b,_) =
        Game.move b (col) in play_game new_b col
      with _ -> print_endline "You force quit the game!")

let () = play_game Board.init 1