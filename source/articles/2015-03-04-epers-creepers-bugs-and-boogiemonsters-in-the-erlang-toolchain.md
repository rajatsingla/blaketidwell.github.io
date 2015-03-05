---
title: EPERs Creepers, Bugs and Boogiemonsters in the Erlang Toolchain
date: 2015-03-04
tags: functional, languages, erlang, elixir, technical
disqus_identifier: /2015/03/04/epers-creepers-bugs-and-boogiemonsters-in-the-erlang-toolchain.html
published: false
---
*Insert a blurb about how it is HARD to build the EPER tool set, or I don't know maybe I'm just a big stupid idiot.*

READMORE

### Running the Test Suite

Why did I start here? I don't know, I guess I :heart: tests or something. Maybe my mother didn't hold me enough as a small child, so I HAVE TO CONFIRM STABILITY BEFORE CODING. Who knows?! Seems like a decent way to figure out how the system ticks, and even get past errors.

* Error: `eunit` tests not passing

```bash
=INFO REPORT==== 4-Mar-2015::19:05:02 ===
Protocol: "inet_tcp": register/listen error: econnrefused
prfDog: t0_test (module 'prfDog')...*failed*
in function prfHost:assert_proxy/1 (src/prfHost.erl, line 67)
in call from prfHost:start/4 (src/prfHost.erl, line 26)
in call from prfDog:t0_test/0 (src/prfDog.erl, line 178)
**exit:{no_proxy,nonode@nohost}
```

* Solution: Start `epmd` in "daemon" mode

```bash
epmd -daemon
```

* Follow up: What the heck is epmd? How do I manage this service on a Mac? Is it `lunchy` compatible? launchd? initctl?  CAN I JUST SHOUT AT IT.

* Error: gperfGtk is missing something

```bash
src/gperfGtk.erl:386: Warning: gperfGtk:g/1 calls undefined function gtknode:cmd/2 (Xref)
src/gperfGtk.erl:37: Warning: gperfGtk:init/0 calls undefined function gtknode:start/1 (Xref)
src/sherk.erl:567: Warning: sherk:g/1 calls undefined function gtknode:cmd/2 (Xref)
src/sherk.erl:56: Warning: sherk:init/0 calls undefined function gtknode:start/1 (Xref)
ERROR: xref failed while processing /Users/BTidwellGrio/Code/elx_workspace/eper: rebar_abort
make: *** [xref] Error 1
```

* Solution: