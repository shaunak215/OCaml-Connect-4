(lang dune 2.9)
(generate_opam_files true)
(authors "Kyle Wu" "Shaunak Shah")
(maintainers "kwu45@jhu.edu" "shaunak215@gmail.com")
(package
 (name server)
 (synopsis "An OCaml library for Playing Connect4")
 (description "A longer description")
 (depends
  (ounit2 (> 2.0)) ; for each opam dependency list the version
  (core (> 0.14.1)) ; `opam list core` will display which version of core you have
  (dream (> 1.0.0~alpha2))
  (lwt (> 5.4.2))
))