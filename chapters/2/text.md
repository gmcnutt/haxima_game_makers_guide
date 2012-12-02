# 2. Hello World

In this chapter you will create your first world. I'll show you the minimal
amount of code and other stuff you need to get a guy on the screen walking
around, and I'll talk about some of the principles behind what is going on.

If you look at the src directory for this chapter you will see that a lot has
been added. Just to get a guy walking around on a map you must provide a broad
but shallow set of definitions. You must define the map, the terrain on it, the
guy, his movement mode and how it relates to the terrain, and a few other
things which aren't strictly necessary for walking around but which the engine
expect at start-of-session.

There is far too much material to cover in a single chapter. For now, just copy
the contents of the chapter src directory into your MyGame folder. If you open
a shell and go to your MyGame directory, you should be able to enter this
command:

    nazghul haxima.scm

And you should see:

When you are ready to quit, just type Q and follow the prompts.


I will highlight a few of the top level files in this chapter. Future chapters
will discuss the contents of the other files as we add to them.

## haxima.scm

The haxima.scm file that you used above is the file for starting a new game
from the beginning. You can name this file whatever you like, such as
mygame.scm. You can even make different starting scenarios in different files
(I often do for testing). The file is mostly comments, on lines that begin with
";;". 

```scheme
;; This file is the startup script for Haxima. It is invoked any time the
;; player wants to start a new Haxima game. Once the player has saved a game
;; and wants to resume it, the save file should be invoked instead of this.

;; Every game startup script must begin by loading naz.scm. It will define some
;; common utilities and load the game system.
(load "naz.scm")

;; Load the data specific to the start of a new session. This adds all the
;; starting maps, characters, objects, etc.
(kern-load "data/init.scm")

;; Register a procedure to run at start-of-game that will put the player on the
;; world map at coordinates (15, 15). The second arg to kern-add-hook must be a
;; quoted symbol, so it must be a named procedure (ie, not a lambda expression).
(define (new-start kplayer)
  (println "starting....")
  (kern-obj-put-at kplayer (list p_world 10 5)))
(kern-add-hook 'new_game_start_hook 'new-start)
```

For those unfamiliar with scheme I'll discuss what is happening in some detail.

The (load "naz.scm") procedure will load and evaluate a file called "naz.scm"
(which we will discuss next). This file must be the first thing that every game
loads. When the engine creates a save-game file, it automatically puts this
load command at the top. As discussed below, the "naz.scm" file loads the game
system.

The next things that must be done is to load the data that defines the start of
a new game, which is what (load "data/init.scm") will do.

Finally, the last step is to tell the engine where to put the player at the
start of a game. This involves two steps: defining a procedure which positions
the player and then hooking it to the start-of-new-game event. In a later
chapter we will change this procedure to do a fancier intro.

The way to define a procedure in scheme is with the "define" keyword. The
format is (define (PROCEDURE argname1 argname2 <etc>) BODY), where BODY is a
list of scheme expressions. Here PROCEDURE is called "new-start" and it expects
the engine to call it with one arg: the player party. The arg will be a
reference to an object in the engine itself, and by convention I name such args
starting with the letter "k" (for kernel).

     "define" is the keyword to make a procedure
       |     name of procedure
       |          |    name of first argument
       |          |       |
    (define (new-start kplayer)
      (println "starting....")                        } first line of body
      (kern-obj-put-at kplayer (list p_world 10 5)))  } last line of body

When the game starts, our procedure will print a line to the console, which is
only for debug (it is invisible unless you start nazghul from a shell), and
then it will invoke another engine procedure called kern-obj-put-at. This
procedure expects two args: a reference to an object in the engine (aka a
kernel object) and a location. The location must be a list of three items. The
first is the place, the second and third are the x and y coordinates.

       engine procedure to put something on a map
               |       thing to put (kernel object)
               |          |     where to put it (scheme list)
               |          |            |
               |          |    /-----------------\
               |          |          place   x  y
               |          |            |     |  |
      (kern-obj-put-at kplayer (list p_world 10 5)))

You may wonder what p_world is. It's a reference to the wilderness map, which
was created during the (load "data/init.scm") call. You'll see where and how
that was done in the next chapter.

    If you are a programmer you have probably inferred that p_world was setup
    as a global variable. That's true. The scheme interpreter has a top-level
    (ie, global) environment and when the game loads most things are defined at
    that level. Good or bad, that's how the initialization scripts locate the
    things they need. Once the game is running most script procedures are run
    as hooks or callbacks and they are passed the parameters they need.

That creates the procedure. Now we must hook the procedure up to run when a new
game starts. This is done with another engine procedure called
kern-add-hook. This procedure takes two args: the event to hook up to, and the
procedure to hook up to it. The engine supports a limited set of events which
may be hooked to script procedures like this, and the start of a new game is
one of them.

    (kern-add-hook 'new_game_start_hook 'new-start)

The ' characters in front of the arguments are mandatory. They tell the scheme
interpreter to accept these arguments as symbols and not to try and evaluate
them. If you didn't understand that statement don't worry.

## naz.scm

One of the most important top-level files is naz.scm, which, stripped of
comments, is just this:

    ;; naz.scm is the traditional name of the file that loads the game system. It
    ;; needs to be the first thing loaded by a session startup script, and the
    ;; nazghul engine is hard-coded to ensure every saved game starts by loading
    ;; this.
    
    ;; Load the top-level init. This adds some generic scheme utilities.
    (load "init.scm")
    
    ;; Load some generic custom utilities.
    (load "utils.scm")
    
    ;; Load the game system. This adds all the object types and various constants
    ;; and procedures needed for any haxima-style game.
    (load "system/init.scm")

This file MUST be named naz.scm. It is a special file which the engine "knows"
about and expects to exist. This requirement is because of the way the engine
saves games. All it does is load some other files in a particular order. I
won't discuss these in any detail at this point.

"init.scm" defines a lot of generic scheme utilities used by the rest of the
system. You should never need to change anything in this file.

"utils.scm" defines some common utilities used by the rest of the haxima
system. You probably won't need to change anything here, either.

"system/init.scm" is what loads the game rule system. The contents of the
"system" directory are like the core rule set for a tabletop RPG. If you open
the file you see it just loads some other files in the subdirectory. By
convention, every subdirectory should have an init.scm file which loads all the
other files needed from that subdirectory in the proper order. We'll be
discussing the contents of these files in later chapters.

## Layout

A game has two parts: system data that is the same for every game of that
type, which I choose to call system data; and session data that describes the
state of the game world when it is saved. The 'data' directory is the latter,
but for the initial starting game.

Another way to say it is that all of the stuff needed to define a haxima-like
game -- ANY haxima-like game -- goes under the system directory. This includes
object types, npc types, AI code or spell definitions, etc. On the other hand,
anything that is needed to initialize a particular instance of YOUR game goes
into data. This includes maps, specific npc characters, books, etc.

Yet another way to say it is that the system is analogous to the core rule set
of a tabletop RPG, whereas the data is the expansion module for a particular
adventure setting.

If you think back you will see that the load order is like this:

    haxima.scm
    |- naz.scm
    |  `- system/init.scm  <--------- core rule set
    `- data/init.scm       <--------- scenario definitions

## Conventions

I've chosen to put all image data under images, and I've broken this up into
engine images (from the last chapter) and system images (for system data).

Under images and data, and every subdir therein, you will find an init.scm
file. This file is used to load other files within the subdir.

Files used to boostrap the engine, and the initial game start file, are at the
top level.

## One Last Note: Saving Games

Start your game again and this time, when you Quit, save a game and call it
"saved.scm". Now look at the contents of your "saves" subdirectory and you
should see three new files:

    MyGame
    `-saves
      |- saved-games.scm
      |- saved.scm
      `- saved.scm.png

Your saved game is in "saved.scm" (as you might expect) and a screenshot for it
is saved in the .png. The "saved-games.scm" file was created automatically by
the engine. It will list all saved games so that the engine knows what they
are, which files are their screenshots, etc.

How does the engine know where to look for saved games? It uses the
"saved-games-dirname" configuration variable, which was added to kern-init.scm
since the last chapter.
