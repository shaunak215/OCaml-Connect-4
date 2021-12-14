(lang dune 2.9)
(name server)

(generate_opam_files true)
(authors "Kyle Wu" "Shaunak Shah")
(maintainers "kwu45@jhu.edu" "shaunak215@gmail.com")

(package
 (name server) 
 (synopsis "An OCaml library for Playing Connect4")
 (description
  "This library allows users to play connect4 on a web server using Dream. There are options to play against an Ai or another player. ")
 (depends
  (ounit2
   (> 2.0)) 
  (core
   (> 0.14.1)) 
  (dream
   (= 1.0.0~alpha2))
  (lwt
   (> 5.4.2))))
