open Core;;
open OUnit2;;
open Connect4.Board;;

(* we should have diff files for testing the board and game and diff files but not sure how to do that *)

let test_player_string _ = 
  let p1 = P1 in let p2 = P2 in let emp = Empty in 
  assert_equal "p1" @@ to_string p1;
  assert_equal "p2" @@ to_string p2;
  assert_equal "na" @@ to_string emp
;;

let test_init _ = 
  assert_equal ([ []; []; []; []; []; []; [] ], P1) @@ init
;;

let test_is_valid_move _ = 
  assert_equal true @@ is_valid_move 1 ([ []; []; []; []; []; []; [] ], P1);
  assert_equal true @@ is_valid_move 1 ([ [P1]; []; []; []; []; []; [] ], P1);
  assert_equal false @@ is_valid_move 0 ([ []; []; []; []; []; []; [] ], P1);
  assert_equal false @@ is_valid_move 8 ([ []; []; []; []; []; []; [] ], P1);
  assert_equal false @@ is_valid_move 1 ([ [P1;P2;P1;P2;P1;P2;]; []; []; []; []; []; [] ], P1);
;;

let test_insert_piece _ = 
  assert_equal ([ [P1]; []; []; []; []; []; [] ], P2) @@ insert_piece 1 ([ []; []; []; []; []; []; [] ], P1);
  assert_equal ([ [P1;P2]; []; []; []; []; []; [] ], P1) @@ insert_piece 1 ([ [P1]; []; []; []; []; []; [] ], P2);
  assert_equal ([ [P1]; []; []; []; []; []; [P2] ], P1) @@ insert_piece 7 ([ [P1]; []; []; []; []; []; [] ], P2);
;;
let test_game_over _ = 
  assert_equal (false,Empty) @@ game_over 1 ([ []; []; []; []; []; []; [] ], P1);
  assert_equal (true,P1) @@ game_over 1 ([ [P1;P1;P1;P1]; [P2;P2;P2]; []; []; []; []; [] ], P2);
  assert_equal (true,P2) @@ game_over 2 ([ [P1;P1]; [P2;P2;P2;P2]; [P1;P1]; [P1]; []; []; [] ], P1);
  assert_equal (true,P1) @@ game_over 4 ([ [P1;P2;P2;P2]; [P1]; [P1]; [P1]; []; []; [] ], P2);
  assert_equal (true,P1) @@ game_over 4 ([ [P2;P1]; [P2;P1]; [P2;P1]; [P1;P1]; [P2]; []; [] ], P2);
  assert_equal (true,P1) @@ game_over 4 ([ [P1]; [P2;P1]; [P2;P1;P1]; [P2;P2;P2;P1]; [P2]; []; [] ], P2);
  assert_equal (true,P1) @@ game_over 4 ([ []; []; []; [P1;P2;P1;P1]; [P2;P2;P1]; [P2;P1]; [P1] ], P2);
  assert_equal (true,P1) @@ game_over 7 ([ []; []; []; []; []; [P2;P2;P2]; [P1;P1;P1;P1] ], P2);
  assert_equal (true,Empty) @@ game_over 7 ([ [P1;P2;P1;P2;P1;P2]; [P1;P2;P1;P2;P1;P2]; [P1;P2;P1;P2;P1;P2]; [P1;P2;P1;P2;P1;P2];
  [P1;P2;P1;P2;P1;P2]; [P1;P2;P1;P2;P1;P2]; [P1;P2;P1;P2;P1;P2]], P1);
  assert_equal (true,P2) @@ game_over 4 ([ [P1;P2;P1;P2;P1;P2]; [P1;P2;P1;P2;P1;P2]; [P1;P2;P1;P2;P1;P2];
    [P2;P1;P2;P1;P2;P2]; [P1;P1]; []; [] ], P1);
  assert_equal (true,P2) @@ game_over 7 ([ [P1;P1]; []; []; [P2;P1;P2;P1;P2;P2]; [P1;P2;P1;P2;P1;P2]; 
    [P1;P2;P1;P2;P1;P2]; [P1;P2;P1;P2;P1;P2] ], P1);
  assert_equal (true,P2) @@ game_over 4 ([ [P1;P1]; []; []; [P2;P1;P2;P1;P2;P2]; [P1;P2;P1;P2;P1;P2]; 
    [P1;P2;P1;P2;P1;P2]; [P1;P2;P1;P2;P1;P2] ], P1);
  assert_equal (false,Empty) @@ game_over 1 ([ [P1;P1;P1]; []; []; []; []; []; [] ], P2);
  assert_equal (false,Empty) @@ game_over 1 ([ [P1]; [P1]; [P1]; []; [P1]; [P1]; [P1] ], P2);
  assert_equal (false,Empty) @@ game_over 1 ([ [P1]; [P1;P1]; [P1;P1;P1]; []; []; []; [] ], P2);
;;

let board_tests = 
  "Board Tests" >: test_list [
    "Player To String" >:: test_player_string;
    "Init" >:: test_init;
    "Is Valid Move" >:: test_is_valid_move;
    "Inset Piece" >:: test_insert_piece;
    "Game Over" >:: test_game_over;
  ]

let series = 
  "Connect 4 Tests" >::: [
    board_tests;
  ]

let () = run_test_tt_main series