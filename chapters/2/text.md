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

## haxima.scm

First, add a file called haxima.scm to the top level of your MyGame directory:

    ;; This file is the startup script for Haxima. It is invoked any time the
    ;; player wants to start a new Haxima game. Once the player has saved a game
    ;; and wants to resume it, the save file should be invoked instead of this.
    
    ;; Every game startup script must begin by loading naz.scm. It will define some
    ;; common utilities and load the game system.
    (load "naz.scm")
    
    ;; Load the data specific to the start of a new session. This adds all the
    ;; starting maps, characters, objects, etc.
    (load "data/init.scm")
    
    ;; Register a procedure to run at start-of-game that will put the player on the
    ;; world map at coordinates (15, 15). The second arg to kern-add-hook must be a
    ;; quoted symbol, so it must be a named procedure (ie, not a lambda expression).
    (define (new-start kplayer)
      (println "starting....")
      (kern-obj-put-at kplayer (list p_world 10 5)))
    (kern-add-hook 'new_game_start_hook 'new-start)

In scheme, the (load "foo") procedure will load and evaluate a file called
"foo". The first thing every game does is load a file called "naz.scm". When
the engine creates a save-game file, it automatically puts this load command at
the top of the save file. It's a convention. One thing naz.scm does is load the
system files (the core rule set, so to speak). 

The next things that must be done is to load the data that defines the start of
a new game, which is what "data/init.scm" will do.

Finally, the last step is to tell the engine where to put the player at the
start of a game. This is done by registering a procedure to be called when the
game starts up. This is called a "hook". The engine supports a limited set of
events which may be hooked, and the start of a new game is one of them. The way
to register a hook is to invoke (kern-add-hook HOOK PROCEDURE). The HOOK must
be one of the symbols the engine supports, in this case 'new_game_start_hook
means the first time a new game is started. The PROCEDURE must be the name of a
procedure with a ' mark in front of it.

    Scheme note: the ' is called the quote character, and it's used to tell the
    scheme interpreter to treat the thing quoted as a symbol and NOT as a
    variable or expression to be evaluated. It's like telling the intepreter,
    "Here's this thing, don't try to figure out what it is right now, just
    accept it."


## naz.scm

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



## Layout

First let me talk about the layout of the directory. Here's a simplified
version:

    MyGame
    |- data      <---- starting game data
    |- images    <---- image files
    `- system    <---- constant game data

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

## Conventions

I've chosen to put all image data under images, and I've broken this up into
engine images (from the last chapter) and system images (for system data).

Under images and data, and every subdir therein, you will find an init.scm
file. This file is used to load other files within the subdir.

Files used to boostrap the engine, and the initial game start file, are at the
top level.

## 

kern-init.scm is from the last chapter.

haxima.scm is the new start file.
