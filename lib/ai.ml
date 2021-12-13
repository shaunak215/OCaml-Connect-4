open Board
open Core

let min_score = -(42 / 2) + 3

let table =
  Hashtbl.create
    (module String)
    ?growth_allowed:(Some false) ?size:(Some 8388593)

let count_moves (b : Board.t) : int =
  let l, _, _ = b in
  List.fold l ~init:0 ~f:(fun accum el -> accum + List.length el)

let is_winning_move (b : Board.t) (col : int) : bool =
  let new_b = insert_piece col b in
  let res, _ = game_over col new_b in
  res

let rec negmax (b : Board.t) (depth : int) (alpha : int) (beta : int) : int =
  if depth > 10 then 0
  else
    let moves = count_moves b in
    if moves = 42 then 0
    else if
      List.for_all [ 1; 2; 3; 4; 5; 6; 7 ] ~f:(fun el ->
          if is_valid_move el b && is_winning_move b el then false else true)
    then
      let _, _, key = b in
      let v = Hashtbl.find table key in
      let max =
        if is_none v then (42 - 1 - moves) / 2
        else Option.value_exn v + min_score - 1
      in
      if beta > max && alpha >= max then max
      else if beta > max then
        negmax_helper b alpha max [ 4; 3; 5; 2; 6; 1; 7 ] depth
      else negmax_helper b alpha beta [ 4; 3; 5; 2; 6; 1; 7 ] depth
    else (42 + 1 - moves) / 2

and negmax_helper (b : Board.t) (alpha : int) (beta : int) (col : int list)
    (depth : int) : int =
  match col with
  | [] ->
      let _, _, moves = b in
      Hashtbl.update table moves ~f:(fun _ -> alpha - min_score + 1);
      alpha
  | hd :: tl ->
      if is_valid_move hd b then
        let new_b = insert_piece hd b in
        let score = -negmax new_b (depth + 1) (-beta) (-alpha) in
        if score >= beta then score
        else if score > alpha then negmax_helper b score beta tl depth
        else negmax_helper b alpha beta tl depth
      else negmax_helper b alpha beta tl depth

let rec solver_helper (b : Board.t) (min : int) (max : int) : int =
  if min >= max then min
  else
    let med = min + ((max - min) / 2) in
    let med =
      if med <= 0 && min / 2 < med then min / 2
      else if med >= 0 && max / 2 > med then max / 2
      else med
    in
    let r = negmax b 0 med (med + 1) in
    if r <= med then solver_helper b min r else solver_helper b r max

let solve (b : Board.t) : int =
  let can_win =
    List.fold [ 1; 2; 3; 4; 5; 6; 7 ] ~init:false ~f:(fun _ el ->
        if is_winning_move b el then true else false)
  in
  if can_win then (42 + 1 - count_moves b) / 2
  else
    let moves = count_moves b in
    let min = -(42 - moves) / 2 in
    let max = (42 + 1 - moves) / 2 in
    solver_helper b min max

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
  let col, _ =
    List.fold [ 4; 3; 5; 2; 6; 1; 7 ] ~init:(0, -100)
      ~f:(fun (index, max) col ->
        let v = List.nth_exn l (col - 1) in
        if v > max then (col, v) else (index, max))
  in
  col

let get_valid_cols (b : Board.t) : int list =
  List.fold [ 1; 2; 3; 4; 5; 6; 7 ] ~init:[] ~f:(fun accum el ->
      if is_valid_move el b then el :: accum else accum)
  |> List.rev

let get_random_col (l : int list) : int =
  let rand = Random.int (List.length l) in
  List.nth_exn l rand

let make_move (b : Board.t) (ai : bool) : Board.t * int =
  if ai then get_scores b |> get_best_col |> fun col -> (insert_piece col b, col)
  else
    let cols = get_valid_cols b in
    let col = get_random_col cols in
    (insert_piece col b, col)
