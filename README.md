Nazghul Game Makers Guide
=========================

This guide is for people who want to make their own ultima-like games but don't
want to write their own engine. It uses the nazghul engine, a project I started
years ago expressly for this purpose.

But first let me discourage you. The nazghul engine is not easy to work
with. Your game will be mostly written in scheme, an unpopular language with
few advocates. The engine itself is a horrid mixture of C and C++. The
interface between the engine and the script is somewhat ad-hoc. It has a
functional but unfriendly terrain editor. In summary, most of your work will be
in a text editor, and it will be a lot of work -- making a game like haxima
takes an enormous amount of time.

But there is some hope. First of all, nazghul is very stable with very few
known bugs. Second, scheme is pretty easy to learn in and of itself and you may
be in the small percentage of the population that loves it. Thirdly, you have
this manual to guide you. And finally, for some people, making a game is more
rewarding than any other human endeavor, and the challenges are worth facing.

## Downloading And Installing

As of this writing the latest nazghul release is 0.7.1. You can download it
here:

http://sourceforge.net/projects/nazghul/files/nazghul/nazghul-0.7.1/

### Windows

1. Download nazghul-0.7.1-setup.exe
2. Run it, making note of where the installer puts it (on my 64-bit Windows 7
   system it put it in C:\Program Files (x86)\Haxima)
3. Make sure the game runs.

Keep track of where the installer put it because you will need this info in
future chapters.

### Other OS's

For other systems you will have to compile the engine. Make sure your system
has the following packages (names here are for debian, redhat and others may
use slightly different package names):

    gcc
    g++
    libsdl-image-dev
    libsdl-mixer-dev
    libsdl-dev
    libpng-dev

If you're not sure if you have those packages or not go ahead with the next
steps. The configure script below will complain about what's missing.

1. Download nazghul-0.7.1-tar.gz
2. From a shell, untar and compile it:

    tar -xzf nazghul-0.7.1-tar.gz
    cd nazghul-0.7.1
    ./configure
    make
    sudo make install

(If you don't want to install as root with sudo -- I never do -- then run
./configure with the --prefix=$HOME option, and it will install into your user
directory.)

3. Make sure the game runs:

    nazghul

## Now What?

The rest of this guide is divided into chapters. Each chapter has a text.md
file which covers a subject, building on previous chapters. Each chapter also
has a src directory which shows what the example project should look like at
the end of the chapter.

Good luck.
