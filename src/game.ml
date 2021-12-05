[@@@ocaml.warning "-27"]

open Board
open Core

let new_game (p : int) : Board.t = init

let move (board : Board.t) (col : int) : Board.t * bool =
  if is_valid_move col board then (insert_piece col board, true)
  else (board, false)

(* might need to add a check that the game string is all valid and all cols are 1-7 and ints *)
let load_game (game : string) (num : int) : Board.t =
  String.fold game ~init ~f:(fun b el ->
      let col = int_of_string @@ Char.escaped el in
      let accum, _ = move b col in
      accum)

let save_game (board : Board.t) : string * int =
  let b, _ = board in
  let compress =
    List.foldi b ~init:"" ~f:(fun i comp col ->
        let new_s =
          String.init (List.length col) ~f:(fun _ ->
              string_of_int @@ (i + 1) |> String.to_list |> fun temp ->
              List.hd_exn temp)
        in
        String.concat [ comp; new_s ])
  in
  (compress, 2)

let print_list (l : player list) : unit =
  List.iter l ~f:(fun el -> printf "%s " (to_string el));
  print_string "\n"

let get_row (row : int) (b : player list list) : player list =
  List.rev
  @@ List.fold b ~init:[] ~f:(fun init l ->
         match List.nth l row with Some p -> p :: init | None -> Empty :: init)

let render (board : Board.t) : unit =
  let b, player = board in
  List.iter [ 5; 4; 3; 2; 1; 0 ] ~f:(fun el -> print_list @@ get_row el b);
  printf "It is player %s's turn\n\n" (Board.to_string player)
