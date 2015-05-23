---
title: Drinking The Koolixir (Part 2) - EPERs Creepers, The Erlang Toolkit!
date: 2015-03-04
tags: functional, languages, erlang, elixir, technical
disqus_identifier: /2015/03/04/epers-creepers-bugs-and-boogiemonsters-in-the-erlang-toolchain.html
---
To get a better handle on Erlang's behavior, I decided to install a popular set
of tools for debugging and performance profiling: EPER. I *think* it stands for
"Erlang PERformance tools", but it could also mean "Everything Proves Erlang
Rules" or "Egrets Prefer to Eat Robots" or really anything for that matter. One
thing is for certain, however: getting these tools built and running on Mac OS X
was fraught with :fire:danger:fire: and :boom: build errors. :boom:.

READMORE

## Running the Test Suit
Before I got down to the business of trying to `make` and `make install` EPER,
it made sense to run `make test` to ensure everything was in working order. Why
start there? I don't know, I guess I :heart: tests or something. Maybe I was
abandoned as a child with a tribe of poorly tested hunter-gatherers, so I HAVE
TO CONFIRM STABILITY BEFORE CODING. Who knows?! :tired_face: Seemed like a
decent way to figure out how the system ticks, and learn a little more about how
the pieces of the Erlang environment fit together.

## Problems Arise
### EPMD
Le duh. Right off the bat, I ran into issues with `eunit` tests not passing.
Specifically, the first run of `make test` yielded the following:

```bash
=INFO REPORT==== 4-Mar-2015::19:05:02 ===
Protocol: "inet_tcp": register/listen error: econnrefused
prfDog: t0_test (module 'prfDog')...*failed*
in function prfHost:assert_proxy/1 (src/prfHost.erl, line 67)
in call from prfHost:start/4 (src/prfHost.erl, line 26)
in call from prfDog:t0_test/0 (src/prfDog.erl, line 178)
**exit:{no_proxy,nonode@nohost}
```

The solution? Start `epmd` in "daemon" mode:

```bash
epmd -daemon
```

That solved the issue, but does raise some more questions. Like: What the heck
is `epmd`? How do I manage this service on a Mac? Is it `lunchy` compatible?
`launchd`? `initctl`?  CAN I JUST SHOUT AT IT. Will definitely be digging deeper
into `epmd` in a future post. For now, we march onward through Error Canyon.

### GTKNode
The installation process next failed because `gperfGtk` claims it is missing
something:

```bash
src/gperfGtk.erl:386: Warning: gperfGtk:g/1 calls undefined function gtknode:cmd/2 (Xref)
src/gperfGtk.erl:37: Warning: gperfGtk:init/0 calls undefined function gtknode:start/1 (Xref)
src/sherk.erl:567: Warning: sherk:g/1 calls undefined function gtknode:cmd/2 (Xref)
src/sherk.erl:56: Warning: sherk:init/0 calls undefined function gtknode:start/1 (Xref)
ERROR: xref failed while processing /Users/BTidwellGrio/Code/elx_workspace/eper: rebar_abort
make: *** [xref] Error 1
```

A little Garggling turned up the fact that `gtknode` is an OSS Erlang library
for mapping to the popular UI library, GTK. I pulled down [the
repo](https://github.com/massemanet/gtknode), and after a little more digging,
found the command for building and installing it:

```
aclocal ; autoconf ; automake ; ./configure --prefix=/your/cool/prefix ; make ; make install
```

For the prefix here, I personally like to keep all of my shell/library Erlang in
a `.erllib` folder in my home directory. I track a couple of helper files in the
same folder in a dotfiles repo, and ignore the build output of all the remaining
libraries.

The first run of the `gtknode` build exited with:

```
Checking for GTK... no
configure: error: Package requirements (gmodule-2.0 libglade-2.0 gtk+-2.0,
gdk-pixbuf-2.0) were not met:

Package 'libxml-2.0', required by 'libglade-2.0', not found

Consider adjusting the PKG_CONFIG_PATH environment variable if you
installed software in a non-standard prefix.
```

This story checks out; one can fairly safely assume that a library named
`gtkWHATEVER` will, in fact, need some other thing called `GTK`. The `README`
for `gtknode` encourages the use of Homebrew to install `glade` (amongst myriad
other things). This first required adding the X11 homebrew tap. Additionally, a
couple more runs of the build script revealed a dependency on XQuart, which is
easily managed using Homebrew Cask. As I had never used Cask up to this point, I
have included it in the installation steps below:

```
brew tap homebrew/x11
brew install glade fontconfig freetype libpng
brew install caskroom/cask/brew-cask
brew cask doctor # This triggers a sudo prompt to configure needed directories
brew cask install xquartz
```

Since we installed `glade` and some of the other libraries using Homebrew,
running another build will result in `"Package 'xcb-shm', required by 'cairo',
not found"` (or any number of other `"[Package] not found"` errors). I am not
completely familiar with `pkg-config`, but it seems the gist of the problem is
that Homebrew installs binaries and libraries in non-default locations (at least
from a Linux perspective). This can be fixed by exporting the `pkgconfig`
environment variable\*:

```
PKG_CONFIG_PATH=/usr/local/opt/libxml2/lib/pkgconfig:/usr/local/lib/pkgconfig:/opt/X11/lib/pkgconfig
```

\**This lovely bit of minutiae comes courtesy of a completely unrelated page in
the [node-canvas Wiki](https://github.com/Automattic/node-canvas/wiki/Installation---OSX).*

With all this in place, `gtknode` should compile, and `make test` from the
`eper` project root should pass. Then, the EPER project can be built using the
same tune as `gtknode`:

```
aclocal ; autoconf ; automake ; ./configure --prefix=/your/cool/prefix ; make ; make install
```

## Then What?
Now that these libraries are compiled and installed using the prefix we provided
earlier, we can add them to the Erlang shell using the `ERL_LIBS` environment
variable. If you used the same convention stated here (i.e. `.erllib` in the
home directory), then this variable should look like the following:

```
export ERL_LIBS="$HOME/.erllib/lib/erlang/lib/eper-0.90.0:$HOME/.erllib/lib/erlang/lib/gtknode-0.32"
```

On startup, the Erlang shell will load any source code in the `ebin` directory
of any libraries spelled out in the `ERL_LIBS` variable. If you refresh this
environment variable and then run `erl` from the command-line, you should be
able to sanity-check installation of EPER by running `redbug:help().` inside the
Erlang shell. This should output a list of methods supported by Redbug.
Additionally, if you do not include the compiled `gtknode` libs using `ERL_LIBS`
as explained above, attempting to use `sherk` performance tools from the Erlang
shell will result in a bunch of errors related to being unable to find `gtkNode`
(similar to the installation process).

With this in place, I feel like I can move forward with learning Erlang in a
much more disciplined way. Now, when something goes wrong deep in the depths of
some wacky Erlang function, I can do some code spelunking courtesy of `redbug`
instead of being all like, "Hey Erlang, WHAT UP IN THERE YO like maybe you
could JUST START WORKING NOW." I may follow-up with a dedicated post
on redbug or just interweave it with future blog posts, but either way you can
expect to see more about proper `redbug` usage here on my blarg.
