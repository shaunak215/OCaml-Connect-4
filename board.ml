open Core

(* 
    This is the representation of a player, 
    It will be used for marking spots and determining whose turn it is
*)
type player = P1 | P2 | Empty

type t = player list list * player

let init: t = [[];[];[];[];[];[];[]], P1

let is_valid_move (col: int) (brd: t): bool =
  if Int.(<) col 0 || Int.(>) col 7 then false
  else
    let b, _ = brd in
    let col_list = List.nth b (col - 1) in
    match col_list with
    | Some l -> 
      if List.length l <= 6 then true
      else false
    | None -> false

let insert_piece (col: int) (brd: t): t =
  let b, player = brd in
  let new_brd = 
    List.rev @@ 
    List.foldi b ~init:[] ~f:(fun index init list ->
      if index = col - 1 then (list @ [player]) :: init
      else list :: init)
  in
  match player with
  | P1 -> new_brd, P2
  | P2 -> new_brd, P1
  | Empty -> failwith "empty in insert_piece"

  let game_over (brd: t ) = 
    if is_valid_move 1 brd then false, P1
    else false, P1
