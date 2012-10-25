Haxima Game Makers Guide
========================

# Downloading And Installing

# Hello World

## The Minimal Setup

Make a directory with some image files like this:

    .
    ├── images
    │   └── system
    │       ├── 640x480_splash.png
    │       ├── charset.png
    │       ├── cursor.png
    │       ├── frame.png
    │       ├── progress_bar_image.png
    │       └── splash.png
    └── kern-init.scm

You can figure out the format of the image files by studying the ones that come
with Haxima. kern-init.scm is a scm file and it should have the following
settings to match this directory layout:

    (kern-cfg-set 
    
     ;; This is the image file for the UI border. The pieces need to be arranged in
     ;; a specific order in this image.
     "frame-image-filename"  "images/system/frame.png"
    
     ;; These are the letters used by the console, etc, in the UI. The character
     ;; sprites need to be arranged in a specific order in this image.
     "ascii-image-filename"  "images/system/charset.png"
    
     ;; This is the cursor prompt used by the command window in the UI. It should
     ;; have four animation frames.
     "cursor-image-filename" "images/system/cursor.png"
    
     ;; This is the script file run when the user selects the "Start New Game"
     ;; option from the main menu.
     "new-game-filename"     "start-new-game.scm"
    
     ;; This is the script file run when the user selects the "Journey Onward"
     ;; option from the main menu. It lists the current save files.
     "save-game-filename"     "saved-games.scm"
    
     ;; This is the script file run when the user selects the "Tutorial"
     ;; option from the main menu.
     "tutorial-filename"     "tutorial.scm"
    
     ;; This is the script file which runs the demo scene on startup.
     "demo-filename" "demo.scm"
    
     ;; These are the filenames of the splash image shown on startup for the
     ;; various supported screen sizes. The format of the key must be
     ;; <width>x<height>-splash-image-filename.
     "1280x960-splash-image-filename" "images/system/splash.png"
     "640x480-splash-image-filename" "images/system/640x480_splash.png"
     "800x480-splash-image-filename" "images/system/640x480_splash.png"
    
    ;; This is the image for the sprite pieces of the progress bar.
    "progress-bar-image-filename" "images/system/progress_bar_image.png"
    
     )
    
Now cd to that directory and start nazghul:

    nazghul

You should see:

![Screenshot of minimal setup](screenshots/minimal.png)
