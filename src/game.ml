[@@@ocaml.warning "-27"]

let new_game (p:int) : Board.t =
  assert false


let load_game (game :string * int) : Board.t =
  assert false

let save_game (board: Board.t) : string * int =
  assert false

let move (board: Board.t) (col: int) : Board.t =
  assert false

let render (board: Board.t) : unit =
  assert false

let pll_to_arr (p: Board.player list list) : string array =
  assert false

let arr_to_pll (ar: string array) : Board.player list list =
  assert false

