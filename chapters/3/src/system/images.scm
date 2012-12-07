;; The sprite image sets. These reference sheets of tile images that sprites
;; point into.
;;
;; Args to kern-mk-images:
;;
;;          tag : qsym, for reference by other parts of the script
;;        width : int, of the tiles in pixels
;;       height : int, of the tiles in pixels
;;     filename : string, path to image file
;;

(kern-mk-images 'img_characters 32 32 "images/system/characters.png")
(kern-mk-images 'img_terrains 32 32 "images/system/terrains.png")
(kern-mk-images 'img_crosshair 32 32 "images/system/crosshair.png")
