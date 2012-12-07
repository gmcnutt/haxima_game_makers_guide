;; The game sprites.

;; Args to kern-mk-sprite:
;;
;;        tag : qsym, for reference by other parts of the script
;; sprite set : sym, reference to the sprite sheet that contains the images
;; num images : int, number of images used by the sprite
;;      index : int, offset of the first image in the sprite sheet (the rest
;;              are expected to follow right after)
;;       wave : bool, true for wave sprites
;;    facings : int, code for number of facings (see below)
;;
;; The facing value is the sum of all facings provided by this sprite. The
;; value is determined by adding:
;;
;;    1 NorthWest
;;    2 North
;;    4 NorthEast
;;    8 West
;;   16 Here
;;   32 East
;;   64 SouthWest
;;  128 South
;;  256 SouthEast
;;  512 Up
;; 1024 Down
;; 
;; Common values include:
;;   0 Default facing (only 1 facing, used for all directions)
;;  40 WE facing (eg, horses)
;; 170 NSEW facing (eg, ships)

;; 'mk-sprite-from-image' is a convenience proc for loading a sprite from an
;; image file that contains just the one sprite of normal dimensions as a
;; single animation frame.
(define (mk-sprite-from-image tag fname)
  (kern-mk-sprite tag
		  (kern-mk-images nil 32 32 fname)
		  1 0 #f 0))

;; similar to 'mk-sprite-from-image', but for 8x16 sprites
(define (mk-sprite-from-image-8x16 tag fname)
  (kern-mk-sprite tag
		  (kern-mk-images nil 8 16 fname)
		  1 0 #f 0))

;; Characters
(kern-mk-sprite 's_wanderer img_characters 4 0 #f 0)

;; Terrains
(kern-mk-sprite 's_deep      img_terrains 1 0 #t 0)
(kern-mk-sprite 's_grass     img_terrains 1 1 #f 0)
(kern-mk-sprite 's_mountains img_terrains 1 2 #f 0)
(kern-mk-sprite 's_deck      img_terrains 1 3 #f 0)

;; Town icons
(mk-sprite-from-image 's_town "images/data/towns/tower.png")

;; Odds & ends
(mk-sprite-from-image 's_crosshair "images/system/crosshair.png")
(mk-sprite-from-image 's_damage "images/system/damage.png")
(mk-sprite-from-image-8x16 's_sun "images/system/sun.png")