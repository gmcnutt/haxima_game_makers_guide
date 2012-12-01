;; The starting world place.

(kern-mk-place 
 'p_world    ; tag
 "The World" ; name
 nil         ; sprite 
 (kern-mk-map
  nil 19 19 pal_expanded
  (list
      "__ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ ^^ ^^ ^^ "
      "__ __ __ .. .. .. .. .. .. .. .. .. .. .. __ __ ^^ .. ^^ "
      "__ __ .. .. .. .. .. .. .. .. .. .. .. .. __ __ __ ee __ "
      "__ .. .. .. ^^ .. ^^ .. .. .. .. .. .. .. __ __ __ __ __ "
      "__ .. .. ^^ ^^ .. ^^ ^^ .. .. .. .. .. .. __ __ __ __ __ "
      "__ .. .. .. .. .. .. .. .. .. .. .. .. .. ee __ __ __ __ "
      "__ .. .. ^^ ^^ .. ^^ ^^ .. .. .. .. .. .. __ __ __ __ __ "
      "__ .. .. .. ^^ .. ^^ .. .. .. .. .. .. .. __ __ __ __ __ "
      "__ .. .. .. .. .. .. .. ^^ ^^ ^^ .. .. .. __ __ __ __ __ "
      "__ .. .. .. .. .. .. .. ^^ .. ^^ .. .. .. __ __ __ __ __ "
      "__ .. .. .. .. .. .. .. ^^ .. ^^ .. .. .. __ __ __ __ __ "
      "__ .. .. .. .. .. .. .. .. .. .. .. .. .. __ __ __ __ __ "
      "__ .. .. .. .. .. .. .. .. .. .. .. .. .. __ __ __ __ __ "
      "__ .. .. .. .. .. .. .. .. .. .. .. .. .. __ .. .. .. __ "
      "__ .. .. .. .. .. .. .. ^^ .. ^^ .. .. .. __ .. .. .. __ "
      "__ .. .. .. .. .. .. ^^ ^^ .. ^^ ^^ .. .. __ .. .. .. __ "
      "__ __ .. .. .. .. .. .. ^^ ^^ ^^ .. .. .. __ __ .. __ __ "
      "__ __ __ .. .. .. .. .. .. .. .. .. .. .. __ __ __ __ __ "
      "__ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
  )  )
 #f  ; wraps
 #f  ; underground
 #t  ; wilderness
 #f  ; tmp combat place
 nil ; subplaces
 nil ; neighbors
 nil ; objects
 nil ; hooks
 nil ; edge entrances
 )
