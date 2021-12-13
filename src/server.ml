[@@@ocaml.warning "-27"]

open Core
open Connect4

let board = ref Connect4.Board.init

let ai = ref false

let ai_player = ref 0

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
                     (Template.game_in_progress (get_moves !board) "p1" request)
                 else
                   let _ = ai := true in
                   Dream.html (Template.player_order request)
             | `Ok [ ("order", message) ] ->
                 if int_of_string message = 1 then
                   let _ = ai_player := 2 in
                   Dream.html
                     (Template.game_in_progress (get_moves !board) "p1" request)
                 else
                   let new_board, col = Ai.make_move !board in
                   board := new_board;
                   ai_player := 1;
                   Dream.html
                     (Template.game_in_progress (get_moves !board) "p2" request
                        ~message:"4")
             | _ -> Dream.empty `Bad_Request);
         Dream.get "/play" (fun request ->
             Dream.html
               (Template.game_in_progress (get_moves !board) "p1" request));
         Dream.post "/play" (fun request ->
             match%lwt Dream.form request with
             | `Ok [ ("message", message) ] ->
                 let move = int_of_string message in
                 let new_board, _ = Game.move !board move in
                 let _, next_player, _ = new_board in
                 let game_over, w_player = Board.game_over move new_board in
                 let winner = Board.to_string w_player in
                 board := new_board;
                 if game_over then Dream.html (Template.game_over winner)
                 else if !ai then (
                   let new_board, col = Ai.make_move !board in
                   let _, next_player, _ = new_board in
                   let game_over, w_player = Board.game_over col new_board in
                   let winner = Board.to_string w_player in
                   board := new_board;
                   if game_over then Dream.html (Template.game_over winner)
                   else
                     Dream.html
                       (Template.game_in_progress ~message:(string_of_int col)
                          (get_moves !board)
                          (Board.to_string next_player)
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
                 let moves, players, first =
                   Game.save_game !board num_players !ai_player
                 in
                 let data =
                   [ moves; string_of_int players; string_of_int first ]
                 in
                 if Sys.file_exists_exn "saved_game.txt" then
                   Sys.remove "saved_game.txt";
                 Out_channel.write_lines "saved_game.txt" data;
                 Dream.html Template.goodbye
             | _ -> Dream.empty `Bad_Request);
         Dream.post "/load" (fun request ->
             match%lwt Dream.form request with
             | `Ok [ ("ending", ending) ] ->
                 if Sys.file_exists_exn "saved_game.txt" then (
                   let input = In_channel.read_lines "saved_game.txt" in
                   let moves =
                     if List.length input = 3 then List.nth_exn input 0 else ""
                   in
                   let players = int_of_string @@ List.nth_exn input 1 in
                   let ai_play = int_of_string @@ List.nth_exn input 2 in
                   board := Game.decode_game moves;
                   let _, cur_player, _ = !board in
                   if players = 1 then ai := true;
                   if ai_play = 2 then ai_player := 2
                   else if ai_play = 1 then ai_player := 1
                   else ai_player := 0;
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
                     let new_board, col = Ai.make_move !board in
                     let _, next_player, _ = new_board in
                     let game_over, w_player = Board.game_over col new_board in
                     let winner = Board.to_string w_player in
                     board := new_board;
                     if game_over then Dream.html (Template.game_over winner)
                     else
                       Dream.html
                         (Template.game_in_progress ~message:(string_of_int col)
                            (get_moves !board)
                            (Board.to_string next_player)
                            request))
                 else Dream.html (Template.collect_players request)
             | _ -> Dream.empty `Bad_Request);
         Dream.get "/static/**" (Dream.static "./static");
         (*Dream.get "/:board/:move"
           (fun request -> s
             let b_str = Dream.param "board" request in
             let move = int_of_string @@ Dream.param "move" request in
             let board = Connect4.Game.decode_game b_str in
             let new_board, _ = Connect4.Game.move board move in
             Dream.html @@ Template.render @@ Connect4.Game.encode_game new_board)*)
       ]
  @@ Dream.not_found