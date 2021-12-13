open Core
open Connect4

let get_input (s : string) : char =
  if String.length s > 1 then 'f' else String.get s 0

let get_num_players () : int =
  print_string
    "Enter the number of players you have\n\
     (1) to play the AI, (2) to play a human:  ";
  Out_channel.flush stdout;
  Option.value_exn (In_channel.input_line In_channel.stdin) |> int_of_string

let get_first_player () : int =
  print_string "Do you want to be player (1) or (2):  ";
  Out_channel.flush stdout;
  Option.value_exn (In_channel.input_line In_channel.stdin) |> int_of_string

(* newline currently ends the game *)

let rec play_game (b : Board.t) (last_col : int) (ai : bool) (play : bool) =
  match Board.game_over last_col b with
  | true, Board.Empty ->
      print_string "The game ended in a tie!"; Out_channel.flush stdout;
      exit 1
  | true, Board.P1 ->
      print_string "P1 Won!"; Out_channel.flush stdout;
      exit 1
  | true, Board.P2 ->
      print_string "P2 Won!"; Out_channel.flush stdout;
      exit 1
  | false, _ -> (
      print_string "\n";
      Game.render b;
      if ai && play then
        let new_b, col = Ai.make_move b in
        play_game new_b col ai false
      else print_string "Enter a column you wish to insert in: ";
      Out_channel.flush stdout;
      try
        let str = Option.value_exn (In_channel.input_line In_channel.stdin) in
        match get_input str with
        | '0' .. '9' ->
            let col = int_of_string str in
            let new_b, valid = Game.move b col in
            if valid then play_game new_b col ai true
            else
              print_string "You entered an invalid column. Please try again\n";
            play_game b last_col ai false
        | 'q' ->
            print_string "Goodbye!"; Out_channel.flush stdout;
            exit 1
        | _ ->
            print_string "You entered an invalid command. Please try again.\n"
      with _ ->
        print_endline "You force quit the game!";
        exit 1)

let setup () : int * bool =
  let players = get_num_players () in
  if players = 2 then (players, false)
  else
    let first = get_first_player () in
    if Int.( = ) first 1 then (players, true) else (players, false)

let () =
  let players, first = setup () in
  if players = 1 && first then play_game Board.init 1 true false
  else if players = 1 then play_game Board.init 1 true true
  else play_game Board.init 1 false false