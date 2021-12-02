open Core
open Connect4

[@@@ocaml.warning "-27"]

let get_input (s : string) : char =
  if String.length s > 1 then 'f' else String.get s 0

let rec play_game (b : Board.t) (last_col : int) =
  match Board.game_over last_col b with
  | true, Board.Empty -> print_string "The game ended in a tie!"
  | true, Board.P1 -> print_string "P1 Won!"
  | true, Board.P2 -> print_string "P2 Won!"
  | false, _ -> (
      print_string "\n";
      Game.render b;
      print_string "Enter a column you wish to insert in: ";
      Out_channel.flush stdout;
      try
        let str = Option.value_exn (In_channel.input_line In_channel.stdin) in
        match get_input str with
        | '0' .. '9' ->
            let col = int_of_string str in
            let new_b, valid = Game.move b col in
            if valid then play_game new_b col
            else
              print_string "You entered an invalid column. Please try again\n";
            play_game b last_col
        | 'q' ->
            print_string "Goodbye!";
            exit 1
        | _ ->
            print_string "You entered an invalid command. Please try again.\n"
      with _ ->
        print_endline "You force quit the game!";
        exit 1)

let () = play_game Board.init 1