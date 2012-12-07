# 4. Towns (and sprites)

In this chapter we will add a town to our wilderness map. We will also need a
sprite for our town, so you will see how to add one of those as well. Although
the full source is included in this chapter, I recommend that you start with
the chapter 3 source and add to it yourself as you follow along.

## Add a new sprite

Our town will appear on the wilderness map as a single icon. We'll need a
sprite to represent it. First you will need to make or find a 32x32 PNG image
file to use as the town. You can get one from the shapes.png file that comes
with haxima (this file contains all the freely-released ultima 4 sprites,
enhanced for higher resolution). Name the file tower.png and put it in
images/data/towns/. Next, add this line to system/sprites.scm:

```scheme
(mk-sprite-from-image 's_town "images/data/towns/tower.png")
```

## Create the place

Add a file called town.scm to data/places:

```scheme
(kern-mk-place 
 'p_town ; tag
 "The Town" ; name
 s_town ; sprite (for appearance in wilderness)
 (kern-mk-map 
  'nil 19 19 pal_expanded
  (list
      ".. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. "
      ".. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. "
      ".. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. "
      ".. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. "
      ".. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. "
      ".. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. "
      ".. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. "
      ".. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. "
      ".. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. "
      ".. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. "
      ".. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. "
      ".. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. "
      ".. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. "
      ".. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. "
      ".. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. "
      ".. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. "
      ".. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. "
      ".. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. "
      ".. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. "
   ))
 #f ; wrapping
 #f ; underground (no sunlight)
 #f ; wilderness (larger scale)
 #f ; wilderness combat (temp map)
 nil ; subplaces
 nil ; neighbors
 nil ; contents
 nil ; hooks
 nil ; edge entrances
 )
```

This is very similar to our definition of the world in world.scm, but there are
three important differences:

1. Obviously, the map is different
2. A sprite is passed as the third arg to kern-mk-place (it was nil on the
   world). This is the sprite used to represent the town on the world map. This
   sprite doesn't exist yet, but we will add it soon.
3. The wilderness flag is #f instead of #t.

To include our town in the new game you need to load it from data/init.scm by
adding the following line to that file:

```scheme
(load "data/places/town.scm")
```

## Put the town on the world map

Edit data/places/world.scm. Before, subplaces was nil. Now you will make it a
list of subplaces, where each subplace is itself a list of the place followed
by the x and y coords on the world map, like so:

```scheme
 #t  ; wilderness
 #f  ; tmp combat place
 ; subplaces:
 (list
  (list p_town 11  6))
 nil ; neighbors
 nil ; objects
```

Now run the game. You should see a tower just southeast of the player icon. If
you step on the tower you will enter the town, on the edge from which you
stepped. Likewise if you exit, you will emerge on the world map in the
direction you stepped off.

The new place inside the tower is uninteresting, but now that you know how to
edit maps from the last chapter you can use your imagination to create
something better. Unfortunately your choice of terrain is pretty limited, and
we haven't covered anything like NPC's, so keep reading.
