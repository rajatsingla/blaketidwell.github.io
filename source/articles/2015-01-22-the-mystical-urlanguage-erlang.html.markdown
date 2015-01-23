---
title: The Mystical Ür Language, Erlang
date: 2015-01-22 06:43 UTC
tags: functional, languages, erlang, technical
published: false
---
Tracing back to my CS roots, I am embarking on a journey to learn the mystical secrets of the functional language Erlang.

READMORE

<div style="text-align: center">
<h2>Part 1</h2>
<h5>First Impressions with Erlang</h5>
<h5>&ndash;or&ndash;</h5>
<h5><i>Taking Apart the Car To Learn How to Drive</i></h5>
</div>
<br/>
Yes, functional programming: Land of Lambdas and Bindings and Parenthesis and you're all like `(where(am(I(will)(I)(ever)(return)?)!)1)` and so-forth. To be fair, my only formal experience with FP was a short section in a programming languages course in college (*unless you count Javascript?*&thinsp;) that gave me probably just enough time to learn how to recursively crash my LISP interpreter. Even that was sufficient to give me the impression that functional programming was something that all Serious Programmers should learn during their Careers as Professionals.

I actually started out wanting to learn Elixir because of some impressive benchmarks I read about [over here](https://github.com/mroth/phoenix-showdown). **tldr;** Phoenix pwns all yes even Node.js *and* I'm pretty sure you still get Hipster Cred for writing in Elixir, yey!

Naturally, I was all like, "I want to <strike>be a hipster</strike> write fast APIs!" so I set out straightaway to install Elixir (*using Homebrew, no doy*&thinsp;), started hacking away all furiously (*a Sublime Text syntax package! and a framework! and package managers! and the author like, wrote Ruby! and I write Ruby!*&thinsp;) only to realize pretty quickly that I was going to be at something of a disadvantage if I didn't learn at least *some* Erlang. At the very least, I started imagining all the <span style="font-family: monospace; font-size: 14px">•∆True&nbsp;Hipster&nbsp;Programmers∆•</span> calling me out. "You write Elixir but you've never even written Erlang DIE TRYHARD POSEUR SCUM PEW PEW PEW!" (*Fun Fact: Hipster Programmers spontaneously emit lasers upon the unworthy.*)

Mostly there was the fact that all of the good debuggers and tooling and whatnot were written with Erlang in mind. (*Fun Fact: much of Elixir itself is written in Erlang as a library of macros.*) Also, I'm a sucker for a knowledge.

So here I be.

## The Jourlang Begins
I remembered reading over on Hacker News about a book on Erlang with a particularly clever title: ["Learn You Some Erlang For Great Good"](http://learnyousomeerlang.com/) (written in the spirit of "Learn You a Haskell For Great Good" SUCH FUNNY).

![A mustachioed octopus on the cover of "Learn You Some Erlang For Great Good", the riveting tale of a tremendously talented mollusk functional programming practitioner](IMG_1100.PNG)

At the time, Erlang didn't really mean much to me, other than I knew there was some vague connection between Elixir and Erlang, and less-so between Haskell and Erlang. BUT since I had always wanted to Crush It Hard with FP, I made a mental note to go back to the book when the time was right. After reading about the Phoenix API Mega Hi-Score, I decided the time was indeed right.

### The Good
I blame college for biasing me, but something about functional programming really does feel like The One True Way. I can remember writing my first few recursive algorithms at the university and feeling like "YES THIS IS IT I AM DOING PROGRAMMING." So, yeah, that's a big plus: it just *feels* so much more computer sciency to me (this may or may not proverbially light your proverbial fire). It's a lame reason, I know, but I figured I should get the lame one out of the way right away. I *will* say that I am legitimately excited to learn a new language for the first time in years. Now that that's out of the way, we can get down to talking about The Other Very Serious Reasons why I chose to learn Erlang.

* Concurrency
* And How this Relates to the Technical Climate
* Horizon Expanding
* Support from Renowned Rubyist

### The Bad

### The ∫√ı‡ﬂ€◊