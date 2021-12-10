[@@@ocaml.warning "-27"]

[@@@ocaml.warning "-33"]

open Board
open Core

let count_moves (b : Board.t) : int =
  let l, _ = b in
  List.fold l ~init:0 ~f:(fun accum el -> accum + List.length el)

let is_winning_move (b : Board.t) (col : int) : bool =
  let new_b = insert_piece col b in
  let res, _ = game_over col new_b in
  res

(* code attempt at alpha beta *)

(* let rec negmax (b : Board.t) (alpha : int) (beta : int) : int =
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
     else negmax_helper b alpha beta (col + 1) *)

let rec negmax (b : Board.t) (depth : int) : int =
  if depth > 3 then 0
  else
    let moves = count_moves b in
    if moves = 42 then 0
    else if
      List.for_all [ 1; 2; 3; 4; 5; 6; 7 ] ~f:(fun el ->
          if is_valid_move el b && is_winning_move b el then false else true)
    then
      let best_score = -42 in
      negmax_helper best_score 0 b depth
    else (42 + 1 - moves) / 2

and negmax_helper (score : int) (col : int) (b : Board.t) (depth : int) : int =
  if col = 8 then score
  else if is_valid_move col b then
    let new_b = insert_piece col b in
    let new_score = -negmax new_b (depth + 1) in
    if new_score > score then negmax_helper new_score (col + 1) b depth
    else negmax_helper score (col + 1) b depth
  else negmax_helper score (col + 1) b depth

let solve (b : Board.t) : int =
  let can_win =
    List.fold [ 1; 2; 3; 4; 5; 6; 7 ] ~init:false ~f:(fun accum el ->
        if is_winning_move b el then true else false)
  in
  if can_win then (42 + 1 - count_moves b) / 2 else negmax b 0

let get_scores (b : Board.t) : int list =
  List.fold [ 1; 2; 3; 4; 5; 6; 7 ] ~init:[] ~f:(fun accum el ->
      if is_valid_move el b then
        if is_winning_move b el then ((42 + 1 - count_moves b) / 2) :: accum
        else
          let score = solve @@ insert_piece el b in
          -score :: accum
      else -100 :: accum)
  |> List.rev

let get_best_col (l : int list) : int =
  let col, score =
    List.fold [ 4; 3; 5; 2; 6; 1; 7 ] ~init:(0, -100)
      ~f:(fun (index, max) col ->
        let v = List.nth_exn l col in
        if v > max then (col, v) else (index, max))
  in
  col

let make_move (b : Board.t) : Board.t =
  get_scores b |> get_best_col |> fun col -> insert_piece col b
