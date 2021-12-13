open Core;;
open OUnit2;;
open Connect4.Board;;
open Connect4.Game;;

let test_player_string _ = 
  let p1 = P1 in let p2 = P2 in let emp = Empty in 
  assert_equal "Red" @@ to_string p1;
  assert_equal "Yellow" @@ to_string p2;
  assert_equal "Nobody" @@ to_string emp
;;

let test_init _ = 
  assert_equal ([ []; []; []; []; []; []; [] ], P1, "") @@ init
;;

let test_is_valid_move _ = 
  assert_equal true @@ is_valid_move 1 ([ []; []; []; []; []; []; [] ], P1, "");
  assert_equal true @@ is_valid_move 1 ([ [P1]; []; []; []; []; []; [] ], P1, "");
  assert_equal false @@ is_valid_move 0 ([ []; []; []; []; []; []; [] ], P1, "");
  assert_equal false @@ is_valid_move 8 ([ []; []; []; []; []; []; [] ], P1, "");
  assert_equal false @@ is_valid_move 1 ([ [P1;P2;P1;P2;P1;P2;]; []; []; []; []; []; [] ], P1, "");
;;

let test_insert_piece _ = 
  assert_equal ([ [P1]; []; []; []; []; []; [] ], P2, "1") @@ insert_piece 1 ([ []; []; []; []; []; []; [] ], P1, "");
  assert_equal ([ [P1;P2]; []; []; []; []; []; [] ], P1, "11") @@ insert_piece 1 ([ [P1]; []; []; []; []; []; [] ], P2, "1");
  assert_equal ([ [P1]; []; []; []; []; []; [P2] ], P1, "17") @@ insert_piece 7 ([ [P1]; []; []; []; []; []; [] ], P2, "1");
;;
let test_game_over _ = 
  assert_equal (false,Empty) @@ game_over 1 ([ []; []; []; []; []; []; [] ], P1, "");
  assert_equal (true,P1) @@ game_over 1 ([ [P1;P1;P1;P1]; [P2;P2;P2]; []; []; []; []; [] ], P2, "");
  assert_equal (true,P2) @@ game_over 2 ([ [P1;P1]; [P2;P2;P2;P2]; [P1;P1]; [P1]; []; []; [] ], P1, "");
  assert_equal (true,P1) @@ game_over 4 ([ [P1;P2;P2;P2]; [P1]; [P1]; [P1]; []; []; [] ], P2, "");
  assert_equal (true,P1) @@ game_over 4 ([ [P2;P1]; [P2;P1]; [P2;P1]; [P1;P1]; [P2]; []; [] ], P2, "");
  assert_equal (true,P1) @@ game_over 4 ([ [P1]; [P2;P1]; [P2;P1;P1]; [P2;P2;P2;P1]; [P2]; []; [] ], P2, "");
  assert_equal (true,P1) @@ game_over 4 ([ []; []; []; [P1;P2;P1;P1]; [P2;P2;P1]; [P2;P1]; [P1] ], P2, "");
  assert_equal (true,P1) @@ game_over 7 ([ []; []; []; []; []; [P2;P2;P2]; [P1;P1;P1;P1] ], P2, "");
  assert_equal (true,P2) @@ game_over 7 ([ [P1;P2;P1;P2;P1;P2]; [P1;P2;P1;P2;P1;P2]; [P1;P2;P1;P2;P1;P2]; [P1;P2;P1;P2;P1;P2];
  [P1;P2;P1;P2;P1;P2]; [P1;P2;P1;P2;P1;P2]; [P1;P2;P1;P2;P1;P2]], P1, "");
  assert_equal (true,P2) @@ game_over 4 ([ [P1;P2;P1;P2;P1;P2]; [P1;P2;P1;P2;P1;P2]; [P1;P2;P1;P2;P1;P2];
    [P2;P1;P2;P1;P2;P2]; [P1;P1]; []; [] ], P1, "");
  assert_equal (true,P2) @@ game_over 7 ([ [P1;P1]; []; []; [P2;P1;P2;P1;P2;P2]; [P1;P2;P1;P2;P1;P2]; 
    [P1;P2;P1;P2;P1;P2]; [P1;P2;P1;P2;P1;P2] ], P1, "");
  assert_equal (true,P2) @@ game_over 4 ([ [P1;P1]; []; []; [P2;P1;P2;P1;P2;P2]; [P1;P2;P1;P2;P1;P2]; 
    [P1;P2;P1;P2;P1;P2]; [P1;P2;P1;P2;P1;P2] ], P1, "");
  assert_equal (false,Empty) @@ game_over 1 ([ [P1;P1;P1]; []; []; []; []; []; [] ], P2, "");
  assert_equal (false,Empty) @@ game_over 1 ([ [P1]; [P1]; [P1]; []; [P1]; [P1]; [P1] ], P2, "");
  assert_equal (false,Empty) @@ game_over 1 ([ [P1]; [P1;P1]; [P1;P1;P1]; []; []; []; [] ], P2, "");
  assert_equal (true, Empty) @@ game_over 7 ([[P1; P2; P1; P2; P1; P2]; [P1; P2; P1; P2; P1; P2];[P2; P1; P2; P1; P2; P1]; 
    [P1; P2; P1; P2; P1; P2]; [P1; P2; P1; P2; P1; P2]; [P1; P2; P1; P2; P1; P1]; [P2; P1; P2; P1; P2; P2]], P1, "")
;;

let board_tests = 
  "Board Tests" >: test_list [
    "Player To String" >:: test_player_string;
    "Init" >:: test_init;
    "Is Valid Move" >:: test_is_valid_move;
    "Inset Piece" >:: test_insert_piece;
    "Game Over" >:: test_game_over;
  ]

let test_new_game _ = 
  assert_equal  ([ []; []; []; []; []; []; [] ], P1, "") @@ new_game 0;
;;

let test_move _ = 
  assert_equal (([ [P1]; []; []; []; []; []; [] ], P2, "1"), true) @@ move ([ []; []; []; []; []; []; [] ], P1, "") 1;
  assert_equal (([ [P1;P2]; []; []; []; []; []; [] ], P1, "11"), true) @@ move ([ [P1]; []; []; []; []; []; [] ], P2, "1") 1;
  assert_equal (([ []; []; []; []; []; []; [] ], P1, ""), false) @@ move ([ []; []; []; []; []; []; [] ], P1, "") 0;
  assert_equal (([ []; []; []; []; []; []; [] ], P1, ""), false) @@ move ([ []; []; []; []; []; []; [] ], P1, "") 8;
  assert_equal (([ [P1;P2;P1;P2;P1;P2]; []; []; []; []; []; [] ], P1, "111111"), false) 
    @@ move ([ [P1;P2;P1;P2;P1;P2]; []; []; []; []; []; [] ], P1, "111111") 1;
;;

let test_decode_game _ = 
  assert_equal ([ []; []; []; []; []; []; [] ], P1, "")  @@ decode_game ""; 
  assert_equal ([ [P1]; []; []; []; []; []; [] ], P2, "1")  @@ decode_game "1";
  assert_equal ([ [P1;P2]; []; []; []; []; []; [] ], P1, "11")  @@ decode_game "11";
  assert_equal ([ [P1]; [P2]; [P1]; [P2]; [P1]; [P2]; [P1] ], P2, "1234567")  @@ decode_game "1234567";
  assert_equal ([ [P1;P2]; [P2;P1]; [P1;P2]; [P2;P1]; [P1;P2]; [P2;P1]; [P1;P2] ], P1, "12345671234567")  
    @@ decode_game "12345671234567";
  assert_equal ([ [P1;P2]; [P1;P2]; [P1;P2]; [P1;P2]; [P1;P2]; [P1;P2]; [P1;P2] ], P1, "11223344556677")  
    @@ decode_game "11223344556677";
  assert_equal ([ []; []; []; [P1;P2]; []; []; [] ], P1, "44")  @@ decode_game "44"; 
  assert_equal ([ []; [P1]; []; [P1;P2]; []; []; [] ], P2, "442")  @@ decode_game "442"; 
  assert_equal ([ []; [P1]; []; [P2;P1]; []; []; [] ], P2, "244")  @@ decode_game "244"; 
  assert_equal ([[P1]; [P1; P1; P2]; [P2; P2]; []; [P1; P2]; []; [P2; P1]], P1, "5523172273")
    @@ decode_game "5523172273";

;;

let test_save_game _ = 
  assert_equal ("", 2, (-1), true) @@ save_game ([ []; []; []; []; []; []; [] ], P1, "") 2 (-1) true ;
  assert_equal ("3412765", 1, (1), true) @@ save_game ([ [P1]; [P2]; [P1]; [P2]; [P1]; [P2]; [P1] ], P2, "3412765") 1 1 true ;
  assert_equal ("11223344556677", 1, 2, false) 
    @@ save_game ([ [P1;P2]; [P1;P2]; [P1;P2]; [P1;P2]; [P1;P2]; [P1;P2]; [P1;P2] ], P1, "11223344556677") 1 2 false;
;;

let test_load_game _ = 
  assert_equal (([ []; []; []; []; []; []; [] ], P1, ""), 2, (-1), false) @@ load_game "" 2 (-1) false ;
  assert_equal (([[P1]; []; [P2; P2]; [P1]; [P1]; [P2]; []], P1, "534613"), 2, 2, true ) @@ load_game "534613" 2 (2) true ;
  assert_equal (([ [P1;P2]; [P1;P2]; [P1;P2]; [P1;P2]; [P1;P2]; [P1;P2]; [P1;P2] ], P1, "11223344556677"), 2, (1), true ) 
    @@ load_game "11223344556677" 2 (1) true ;
;;

let game_tests = 
  "Game Tests" >: test_list [
    "New Game" >:: test_new_game;
    "Move" >:: test_move;
    "Decode Game" >:: test_decode_game;
    "Save Game" >:: test_save_game;
    "Load Game" >:: test_load_game;
  ]

let series = 
  "Connect 4 Tests" >::: [
    board_tests;
    game_tests;
  ]

let () = run_test_tt_main series