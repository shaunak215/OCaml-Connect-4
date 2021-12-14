open Board
open Core

let new_game (_ : int) : Board.t = init

let move (board : Board.t) (col : int) : Board.t * bool =
  if is_valid_move col board then (insert_piece col board, true)
  else (board, false)

let decode_game (game : string) : Board.t =
  String.fold game ~init ~f:(fun b el ->
      let col = int_of_string @@ Char.escaped el in
      let accum, _ = move b col in
      accum)

let print_list (l : player list) : unit =
  List.iter l ~f:(fun el -> printf "%s " (to_string el));
  print_string "\n"

let get_row (row : int) (b : player list list) : player list =
  List.rev
  @@ List.fold b ~init:[] ~f:(fun init l ->
         match List.nth l row with Some p -> p :: init | None -> Empty :: init)

let load_game (encode : string) (num : int) (cur : int) (ai : bool) :
    Board.t * int * int * bool =
  let decode = decode_game encode in
  (decode, num, cur, ai)

let save_game (b : Board.t) (num : int) (cur : int) (ai : bool) :
    string * int * int * bool =
  let _, _, compress = b in
  (compress, num, cur, ai)

let render (board : Board.t) : unit =
  let b, player, _ = board in
  List.iter [ 5; 4; 3; 2; 1; 0 ] ~f:(fun el -> print_list @@ get_row el b);
  printf "It is player %s's turn\n\n" (Board.to_string player)
