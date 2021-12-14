[@@@ocaml.warning "-27"]

open Core
open Connect4

let board = ref Connect4.Board.init

let ai = ref false

let ai_player = ref 0

let ai_difficulty = ref true

let get_moves (b : Board.t) : string =
  let _, _, moves = b in
  moves

let () =
  Dream.run @@ Dream.logger @@ Dream.memory_sessions
  @@ Dream.router
       [
         Dream.get "/" (fun request ->
             Dream.html (Template.collect_players request));
         Dream.post "/" (fun request ->
             match%lwt Dream.form request with
             | `Ok [ ("players", message) ] ->
                 if int_of_string message = 2 then
                   Dream.html
                     (Template.game_in_progress (get_moves !board) "Red" request)
                 else
                   let _ = ai := true in
                   Dream.html (Template.get_difficulty request)
             | `Ok [ ("difficulty", message) ] ->
                 if String.( = ) message "true" then ai_difficulty := true
                 else ai_difficulty := false;
                 Dream.html (Template.player_order request)
             | `Ok [ ("order", message) ] ->
                 if int_of_string message = 1 then
                   let _ = ai_player := 2 in
                   Dream.html
                     (Template.game_in_progress (get_moves !board) "Player" request)
                 else
                   let new_board, col = Ai.make_move !board !ai_difficulty in
                   board := new_board;
                   ai_player := 1;
                   Dream.html
                     (Template.game_in_progress (get_moves !board) "Player" request
                        ~message:"4")
             | `Ok [ ("reset", message) ] ->
                 ai := false;
                 ai_player := 0;
                 ai_difficulty := true;
                 board := Connect4.Board.init;
                 Dream.html (Template.collect_players request)
             | _ -> Dream.empty `Bad_Request);
         Dream.get "/play" (fun request ->
             Dream.html
               (Template.game_in_progress (get_moves !board) "Red" request));
         Dream.post "/play" (fun request ->
             match%lwt Dream.form request with
             | `Ok [ ("message", message) ] ->
                 let move = int_of_string message in
                 let new_board, _ = Game.move !board move in
                 let _, next_player, _ = new_board in
                 let game_over, w_player = Board.game_over move new_board in
                 let winner = Board.to_string w_player in
                 board := new_board;
                 if game_over then
                   Dream.html
                     (Template.game_over (get_moves !board) winner request)
                 else if !ai then (
                   let new_board, col = Ai.make_move !board !ai_difficulty in
                   let game_over, w_player = Board.game_over col new_board in
                   let winner = Board.to_string w_player in
                   board := new_board;
                   if game_over then
                     Dream.html
                       (Template.game_over (get_moves !board) winner request)
                   else
                     Dream.html
                       (Template.game_in_progress ~message:(string_of_int col)
                          (get_moves !board)
                          ("Player")
                          request))
                 else
                   Dream.html
                     (Template.game_in_progress ~message (get_moves !board)
                        (Board.to_string next_player)
                        request)
             | _ -> Dream.empty `Bad_Request);
         Dream.post "/save" (fun request ->
             match%lwt Dream.form request with
             | `Ok _ ->
                 let num_players = if !ai then 1 else 2 in
                 let moves, players, first, ai =
                   Game.save_game !board num_players !ai_player !ai_difficulty
                 in
                 let data =
                   [
                     moves;
                     string_of_int players;
                     string_of_int first;
                     string_of_bool ai;
                   ]
                 in
                 if Sys.file_exists_exn "saved_game.txt" then
                   Sys.remove "saved_game.txt";
                 Out_channel.write_lines "saved_game.txt" data;
                 Dream.html (Template.saved (get_moves !board) request)
             | _ -> Dream.empty `Bad_Request);
         Dream.post "/load" (fun request ->
             match%lwt Dream.form request with
             | `Ok [ ("ending", ending) ] ->
                 if Sys.file_exists_exn "saved_game.txt" then (
                   let input = In_channel.read_lines "saved_game.txt" in
                   let moves =
                     if List.length input = 4 then List.nth_exn input 0 else ""
                   in
                   let players = int_of_string @@ List.nth_exn input 1 in
                   let ai_play = int_of_string @@ List.nth_exn input 2 in
                   let ai_diff = bool_of_string @@ List.nth_exn input 3 in
                   board := Game.decode_game moves;
                   let _, cur_player, _ = !board in
                   if players = 1 then ai := true;
                   if ai_play = 2 then ai_player := 2
                   else if ai_play = 1 then ai_player := 1
                   else ai_player := 0;
                   if ai_diff then ai_difficulty := true
                   else ai_difficulty := false;
                   if
                     (not !ai)
                     || (String.length moves mod 2 = 0 && ai_play = 2)
                     || (String.length moves mod 2 = 1 && ai_play = 1)
                   then
                     Dream.html
                       (Template.game_in_progress moves
                          (Board.to_string cur_player)
                          request)
                   else
                     let new_board, col = Ai.make_move !board !ai_difficulty in
                     let _, next_player, _ = new_board in
                     let game_over, w_player = Board.game_over col new_board in
                     let winner = Board.to_string w_player in
                     board := new_board;
                     if game_over then
                       Dream.html
                         (Template.game_over (get_moves !board) winner request)
                     else
                       Dream.html
                         (Template.game_in_progress ~message:(string_of_int col)
                            (get_moves !board)
                            (Board.to_string next_player)
                            request))
                 else Dream.html (Template.collect_players request)
             | _ -> Dream.empty `Bad_Request);
         Dream.get "/static/**" (Dream.static "./static");
       ]
  @@ Dream.not_found