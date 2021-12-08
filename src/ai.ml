[@@@ocaml.warning "-27"]

[@@@ocaml.warning "-33"]

open Board
open Core

let count_moves (b : Board.t) : int =
  let l, _ = b in
  List.fold l ~init:0 ~f:(fun accum el -> accum + List.length el)

let is_winning_move (b : Board.t) (col : int) : bool =
  let new_b = insert_piece col b in
  let b, _ = game_over col new_b in
  b

let rec negmax (b : Board.t) (alpha : int) (beta : int) : int =
  let moves = count_moves b in
  if moves = 42 then 0
  else if
    List.for_all [ 1; 2; 3; 4; 5; 6; 7 ] ~f:(fun el ->
        if is_valid_move el b && is_winning_move b el then false else true)
  then
    let max = (42 + 1 - moves) / 2 in
    if beta > max && alpha >= max then max
    else if beta > max then negmax_helper b alpha max 1
    else negmax_helper b alpha beta 1
  else (42 + 1 - moves) / 2

and negmax_helper (b : Board.t) (alpha : int) (beta : int) (col : int) : int =
  if col = 8 then alpha
  else if is_valid_move col b then
    let new_b = insert_piece col b in
    let score = -negmax new_b (-alpha) (-beta) in
    if score >= beta then score
    else if score > alpha then negmax_helper b score beta (col + 1)
    else negmax_helper b alpha beta (col + 1)
  else negmax_helper b alpha beta (col + 1)

let make_move (b : Board.t) : int list =
  List.fold [ 1; 2; 3; 4; 5; 6; 7 ] ~init:[] ~f:(fun accum el ->
      negmax (insert_piece el b) (-21) 21 :: accum)
  |> List.rev
