open Core

(*
     This is the representation of a player,
     It will be used for marking spots and determining whose turn it is
*)
type player = P1 | P2 | Empty

type t = player list list * player * string

let to_string (p : player) : string =
  match p with P1 -> "p1" | P2 -> "p2" | Empty -> "na"

let init : t = ([ []; []; []; []; []; []; [] ], P1, "")

let is_valid_move (col : int) (brd : t) : bool =
  if Int.( < ) col 1 || Int.( > ) col 7 then false
  else
    let b, _, _ = brd in
    let l = List.nth_exn b (col - 1) in
    if List.length l < 6 then true else false

let insert_piece (col : int) (brd : t) : t =
  let b, player, moves = brd in
  let col_index = col - 1 in
  let new_brd =
    List.rev
    @@ List.foldi b ~init:[] ~f:(fun index init list ->
           if index = col_index then (list @ [ player ]) :: init
           else list :: init)
  in
  match player with
  | P1 -> (new_brd, P2, String.concat [ moves; string_of_int col ])
  | P2 -> (new_brd, P1, String.concat [ moves; string_of_int col ])
  | Empty -> failwith "empty in insert_piece"

let is_tie (b : player list list) : bool =
  List.for_all ~f:(fun l -> List.length l = 6) b

let get_row (row : int) (b : player list list) : player list =
  List.rev
  @@ List.fold b ~init:[] ~f:(fun init l ->
         match List.nth l row with Some p -> p :: init | None -> Empty :: init)

let get_right_diagonal (row : int) (col : int) (b : player list list) :
    player list =
  let rec top_of_diag (row : int) (col : int) : int * int =
    if row + 1 <= 6 && col + 1 <= 5 then top_of_diag (row + 1) (col + 1)
    else (row, col)
  in
  let rec iterate (r : int) (c : int) (diag_list : player list)
      (b : player list list) : player list =
    match List.nth b c with
    | None ->
        if r >= 0 && c >= 0 then iterate (r - 1) (c - 1) (Empty :: diag_list) b
        else diag_list
    | Some l -> (
        match List.nth l r with
        | None ->
            if r >= 0 && c >= 0 then
              iterate (r - 1) (c - 1) (Empty :: diag_list) b
            else diag_list
        | Some p -> iterate (r - 1) (c - 1) (p :: diag_list) b)
  in
  let top_row, top_col = top_of_diag row col in
  List.rev @@ iterate top_row top_col [] b

let get_left_diagonal (row : int) (col : int) (b : player list list) :
    player list =
  let rec top_of_diag (row : int) (col : int) : int * int =
    if row + 1 <= 5 && col - 1 >= 0 then top_of_diag (row + 1) (col - 1)
    else (row, col)
  in
  let rec iterate (r : int) (c : int) (diag_list : player list)
      (b : player list list) : player list =
    match List.nth b c with
    | None ->
        if r >= 0 && c <= 6 then iterate (r - 1) (c + 1) (Empty :: diag_list) b
        else diag_list
    | Some l -> (
        match List.nth l r with
        | None ->
            if r >= 0 && c <= 6 then
              iterate (r - 1) (c + 1) (Empty :: diag_list) b
            else diag_list
        | Some p -> iterate (r - 1) (c + 1) (p :: diag_list) b)
  in
  let top_row, top_col = top_of_diag row col in
  List.rev @@ iterate top_row top_col [] b

let connect_four (plist : player list) : bool =
  let check_list =
    List.group plist ~break:(fun p1 p2 ->
        match (p1, p2) with P1, P1 -> false | P2, P2 -> false | _, _ -> true)
  in
  let has_four = List.filter check_list ~f:(fun l -> List.length l >= 4) in
  if List.length has_four = 0 then false else true

let is_win (col : int) (b : player list list) : bool =
  let col_index = col - 1 in
  let col_list = List.nth_exn b col_index in
  let row_index = List.length col_list - 1 in
  let row_list = get_row row_index b in
  let rdiag_list = get_right_diagonal row_index col_index b in
  let ldiag_list = get_left_diagonal row_index col_index b in
  if
    connect_four col_list || connect_four row_list || connect_four rdiag_list
    || connect_four ldiag_list
  then true
  else false

let game_over (col : int) (brd : t) =
  let b, next_player, _ = brd in
  if is_win col b then
    match next_player with
    | P1 -> (true, P2)
    | P2 -> (true, P1)
    | Empty -> failwith "Empty in game over"
  else if is_tie b then (true, Empty)
  else (false, Empty)
