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

## Name

## Wilderness Flag

## kern-mk-map
