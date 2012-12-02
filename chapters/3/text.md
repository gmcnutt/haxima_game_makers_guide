# 3. Maps and Places

In the last chapter the game had a single small wilderness map. In this chapter
you will learn how to change the size and content of a map.

## kern-mk-place

Open data/places/world.scm:

```scheme
;; The starting world place.

(kern-mk-place 
 'p_world    ; tag so that other parts of the code can reference this place
 "The World" ; human-readable name for UI
 nil         ; optional sprite (unused for wilderness maps)
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
 #f  ; does the map wrap on its edges? no
 #f  ; is it underground (ie, no ambient light from the sky)? no
 #t  ; is it wilderness scale? yes
 #f  ; is it a temporary combat zone? no
 nil ; list of subplaces: none
 nil ; list of neighbors: none
 nil ; list of objects and their locations: none
 nil ; list of hooks to run (eg, on entry): none
 nil ; list of edge entrances: none
 )
```

The call to "kern-mk-place" tells the engine to create a new place. A place is
a grid with a terrain map. Each cell in the grid can hold any number of objects
and one character. A place can be a large-scale wilderness "world" or a town,
or a dungeon room, or even a temporary combat zone.

I want you to note that there is a call to kern-mk-map embedded in this. Ignore
that for the moment. The comments describe the other arguments pretty well for
now. Most of them are not used yet and we will see other examples in the future
that make use of them. I'll describe the ones that are used: the tag, the name,
the wilderness flag and the map.

### Tag

The tag assigns a variable name to the new place in such a way that the place
"knows" its tag. If you're wondering why we don't just use scheme's define
keyword to assign a variable, it's because the place needs to know it's tag so
it can be saved. When the engine saves the game, it saves the place as well. In
fact, the way it saves it is by writing a call to kern-mk-place (look in one
of the saved game files). By embedding the tag in the place itself the engine
knows what the tag is. Recall back to the last chapter where in haxima.scm we
defined a startup procedure to put the player on the map:

```scheme
(define (new-start kplayer)
  (println "starting....")
  (kern-obj-put-at kplayer (list p_world 10 5)))
```

That call to kern-obj-put-at uses the tag p_world. This is an example
of referring to an object by its tag.

### Name

The name is displayed in the UI. Whenever the player enters a place the console
prints a message, and the '@' command also described the place.

### Wilderness Flag

The wilderness flag tells the engine that this is a large-scale outdoor
map. The engine uses this to advance time differently when the player moves. It
also tells the engine to show the player party as a single icon. In
non-wilderness places the engine will show all the individual members, one per
tile.

### kern-mk-map

The fourth argument to kern-mk-place is a map. Maps are defined with their own
function, kern-mk-map. This was done to allow maps to be defined separately
from places, and even be re-used in multiple places. As it turns out, this is
useful only in special cases like temporary combat zone maps and dynamically
generated dungeon rooms (future chapters). The first argument to kern-mk-map is
an optional tag. If a map is declared standalone you must provide a tag so that
it can be referenced; but if you embed the declaration like our example then
you don't.

```scheme
(kern-mk-map
 nil ; optional tag (none needed since this example was embedded)
 19  ; width of map in tiles
 19  ; height of map in tiles
 pal_expanded ; palette used to decode the map below
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
 ))
```

LEFT OFF HERE
