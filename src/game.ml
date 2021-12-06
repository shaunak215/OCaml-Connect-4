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

let get_row (row : int) (b : player list list) : player list =
  List.rev
  @@ List.fold b ~init:[] ~f:(fun init l ->
         match List.nth l row with Some p -> p :: init | None -> Empty :: init)

let make_row_list (board : player list list) (row : int) : int list * int list =
  let r = get_row row board in
  List.foldi r ~init:([], []) ~f:(fun i (p1, p2) p ->
      match p with
      | P1 -> ((i + 1) :: p1, p2)
      | P2 -> (p1, (i + 1) :: p2)
      | Empty -> (p1, p2))
  |> fun (p1, p2) -> (List.rev p1, List.rev p2)

let make_full_list (board : Board.t) : int list * int list =
  let b, _ = board in
  List.fold [ 0; 1; 2; 3; 4; 5 ] ~init:([], []) ~f:(fun (p1, p2) el ->
      let new_p1, new_p2 = make_row_list b el in
      (List.append p1 new_p1, List.append p2 new_p2))

let combine_lists (p1 : int list) (p2 : int list) : int list =
  List.foldi p1 ~init:[] ~f:(fun i res el ->
      let temp = el :: res in
      match List.nth p2 i with Some v -> v :: temp | None -> temp)
let save_game (board : Board.t) : string * int =
  let p1, p2 = make_full_list board in
  List.fold (combine_lists p1 p2) ~init:"" ~f:(fun accum el ->
      String.concat [ string_of_int el; accum ])
  |> fun res -> (res, 2)

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
