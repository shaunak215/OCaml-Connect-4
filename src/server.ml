
let () =
  let board = ref Connect4.Board.init in

  Dream.run
  @@ Dream.logger
  @@ Dream.memory_sessions
  @@ Dream.router [

    Dream.get "/"
    (fun request ->
      Dream.html (Template.game_in_progress (Connect4.Game.encode_game !board) "p1" request));

    Dream.post "/"
    (fun request ->
      match%lwt Dream.form request with
      | `Ok ["message", message] ->
        let move = int_of_string message in
        let new_board, _ = Connect4.Game.move !board move in
        let _, next_player = new_board in
        let game_over, w_player = Connect4.Board.game_over move new_board in
        let winner = Connect4.Board.to_string w_player in
        board := new_board;
        if game_over then
          Dream.html (Template.game_over winner)
        else 
          Dream.html (Template.game_in_progress ~message (Connect4.Game.encode_game !board) (Connect4.Board.to_string next_player) request)
      | _ ->
        Dream.empty `Bad_Request);


    (*Dream.get "/:board/:move"
      (fun request -> s
        let b_str = Dream.param "board" request in
        let move = int_of_string @@ Dream.param "move" request in
        let board = Connect4.Game.decode_game b_str in
        let new_board, _ = Connect4.Game.move board move in 
        Dream.html @@ Template.render @@ Connect4.Game.encode_game new_board)*)
        
  ]
  @@ Dream.not_found