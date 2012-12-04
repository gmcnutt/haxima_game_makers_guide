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
prints a message, and the '@' command also describes the place.

### Wilderness Flag

The wilderness flag tells the engine that this is a large-scale outdoor
map. The engine uses this to advance time differently when the player moves. It
also tells the engine to show the player party as a single icon. (In
non-wilderness places like towns the engine will show all the individual
members, one per tile.)

### kern-mk-map

The fourth argument to kern-mk-place is a map. Maps are defined with their own
function, kern-mk-map. The engine was designed this way to allow maps to be
defined separately from places, and even be re-used in multiple places. As it
turns out, this is useful only in special cases like temporary combat zone maps
and dynamically generated dungeon rooms (future chapters). 

The first argument to kern-mk-map is an optional tag, which works exactly the
way tags work for places [1]. If a map is declared standalone you must provide a
tag so that it can be referenced; but if you embed the declaration like our
example then you don't [2].

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

The first three args to kern-mk-map are self-explanatory: tag, width and
height. The fourth arg is the palette (hold on to that thought) and the
last is the actual terrain map.

The terrain map is a list of strings, and each string is a list of
space-separated two-character codes, where each code represents a terrain
type. What do the codes mean? What, for instance, does "^^" mean? That is what
the palette is for.

A palette shows how to convert these codes to terrain types. In this case the
palette is called pal_expanded, and this is a reference to a
previously-declared palette. The palette is found in system/palette.scm and it
is created with a call to kern-mk-palette:

```scheme
(kern-mk-palette 'pal_expanded
		 (list
		  (list "__" t_deep)
		  (list "^^" t_mountains)
		  (list ".." t_grass)
		  (list "ee" t_deck)
		  ))
```

The palette is declared with a tag (pal_expanded) followed by a list of
code-to-terrain-type pairs. So, for example:

```scheme
(list "__" t_deep)
```

means "__" represents the terrain called t_deep. Well, what is t_deep? It's a
terrain type, declared in system/terrains.scm, in a definition like this:

```scheme
  (kern-mk-terrain 't_deep "deep water" pclass-deep s_deep transparent 0 nil)
```

We'll cover terrain types in a later chapter. Getting back to our map
definition, let's change our map by connecting the island in the southeast
corner to the main land mass by converting some water ("__") to grass ("..") on
the fifteenth row:

```scheme
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
    "__ .. .. .. .. .. .. .. ^^ .. ^^ .. .. .. .. .. .. .. __ " ;; <--- changed
    "__ .. .. .. .. .. .. ^^ ^^ .. ^^ ^^ .. .. __ .. .. .. __ "
    "__ __ .. .. .. .. .. .. ^^ ^^ ^^ .. .. .. __ __ .. __ __ "
    "__ __ __ .. .. .. .. .. .. .. .. .. .. .. __ __ __ __ __ "
    "__ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
)
```

Now if you start the game again (as a new game, not Journey Onward) you should
be able to walk across the grass to the island.

What happens if you load a game that was saved before making this change? Does
the change show up in the saved game? Try it and you'll see that it does
not. That's because the saved game has its own copy of the map. It does not
reload the original. If you were to edit the map in the saved game file, it
would show up, and would persist through future games.

Now suppose you wanted to enlarge the map from 19x19 to 19x20. You would need
to make two changes. First, you must change the third argument from 19 to 20;
and then you must add another row, like this:

```scheme
(kern-mk-map
 nil ; optional tag (none needed since this example was embedded)
 19  ; width of map in tiles
 20  ; height of map in tiles
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
     "__ .. .. .. .. .. .. .. ^^ .. ^^ .. .. .. .. .. .. .. __ "
     "__ .. .. .. .. .. .. ^^ ^^ .. ^^ ^^ .. .. __ .. .. .. __ "
     "__ __ .. .. .. .. .. .. ^^ ^^ ^^ .. .. .. __ __ .. __ __ "
     "__ __ __ .. .. .. .. .. .. .. .. .. .. .. __ __ __ __ __ "
     "__ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ __ "
     "^^ .. .. .. __ __ __ __ .. ^^ .. __ __ __ __ __ __ .. ^^ "
 ))
```

Now, what if you wanted to make the map wider? What would you change? You'd
change the second argument (the width) to 20, and you would have to edit every
row, adding another terrain code at the end of every string.

Why are the terrain codes two characters instead of just one? In the game that
ships with the engine, one character is not enough to represent all the terrain
types. Does it have to be this way? Could one define a palette that only used
one character? Yes, if your game only needs a few terrain types you could do
that. In our current example we could easily do this. We could edit the palette
so that "__" was just "_", and then change the map to match. We would still
need to separate the codes with spaces, so the first line would be:

```scheme
"_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ ^ ^ ^ "
```

The opposite is also true: if you create a game with so many terrain types that
two characters is not enough, you could use three or even more. There is no
limit built into the engine.

Editing maps in a text editor is sometimes convenient for tweaking small
details, but it is not a fun way to make large changes or create new
maps. There are better ways to do both that we shall see later.

FOOTNOTES

[1] As you will see, a lot of things have tags, and they all work the same (ie,
    they are global variables).

[2] Because the return value of kern-mk-map is the new map. In general, the
    return value of any kern-mk- call is the newly made thing.
