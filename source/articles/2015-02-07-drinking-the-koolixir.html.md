---
title: Drinking The Koolixir (Part 1)
date: 2015-02-07 02:18 UTC
tags: functional, languages, erlang, elixir, technical
disqus_identifier: /2015-02-07-drinking-the-koolixir.html
---
In case you haven't yet heard of it yet, Elixir is a functional programming
language (technically, a collection of macros) written in Erlang. I have been
persuaded to add it to my technical repertoire due to a good amount of recent
buzz in the blogosphere (as well as some points I'll get to later). To make sure
I have a strong foundation for my Elixir learning experience, I am starting my
adventure with a foray into the underlying syntax of Erlang.

READMORE

<div style="text-align: center">
  <h2>Part 1</h2>
  <h5>First Impressions with Erlang</h5>
  <h5>&ndash;or&ndash;</h5>
  <h5>
    <i>Taking Apart the Car To Learn How to Drive</i>
  </h5>
</div>
<br/>
Yes, functional programming: Land of Lambdas and Bindings and Parenthesis and
you're all like `(where(am(I(will)(I)(ever)(return)?)!)1)` and so-forth. To be
fair, my only formal experience with FP was a short section in a programming
languages course in college (*unless you count Javascript?*&thinsp;) that gave
me probably just enough time to learn how to recursively crash my LISP
interpreter. Even that was sufficient to give me the impression that functional
programming was something that all Serious Programmers should learn during their
Careers as Professionals.

I actually started out wanting to learn Elixir because of some impressive
benchmarks I read about [over here](https://github.com/mroth/phoenix-showdown).
**tldr;** Phoenix pwns all yes even Node.js *and* I'm pretty sure you still get
Hipster Cred for writing in Elixir, yey!

Naturally, I was all like, "I want to <strike>be a hipster</strike> write fast
APIs!" so I set out straightaway to install Elixir (*using Homebrew, no
doy*&thinsp;), started hacking away all furiously (*a Sublime Text syntax
package! and a framework! and package managers! and the author like, wrote Ruby!
and I write Ruby!*&thinsp;) only to realize pretty quickly that I was going to
be at something of a disadvantage if I didn't learn at least *some* Erlang.

At the very least, I started imagining all the
<span style="font-family: monospace; font-size: 14px">&#9679;&Delta;True&nbsp;Hipster&nbsp;Programmers&Delta;&#9679;</span>
calling me out. "You write Elixir but you've never even written Erlang DIE
TRYHARD POSEUR SCUM PEW PEW PEW!" (*Fun Fact: Hipster Programmers spontaneously
emit lasers upon the unworthy.*)There was also the fact that all of the good
debuggers and tooling and whatnot were written with Erlang in mind. Also, I'm a
sucker for a knowledge.

<div class="image-wrapper">
  <img alt="A space cat obliterating a planet of unworthy programmers writing at an unacceptable level of abstraction"
       src="/articles/hipster_programmer_cat.jpg" />
  <blockquote>
    "Oh what's that ur 'getting around' to learning assembly PEW PEW PEW I CANT
    HEER U UR DEAD"
  </blockquote>
</div>

So here I be.

### But Wait, Why Learn "Tonic"...er...whatever?
I blame college for biasing me, but something about functional programming
really does feel like The One True Way. I can remember writing my first few
recursive algorithms and feeling like "YES THIS IS IT I AM DOING PROGRAMMING."
So, yeah, that's a big plus: it just *feels* so much more computer sciency to me
(this may or may not proverbially light your proverbial fire). I can say that I
am legitimately excited to learn a new language for the first time in years, and
that excitement will go a long way toward conquering a potentially powerful new
tool.

That being said, there are also some "serious" reasons why I chose to learn
Erlang/Elixir. By far the most important of these reasons is that Erlang touts
concurrency and fault-tolerance as being core benefits of the language and the
accompanying BEAM VM. Given the current push in the tech industry for
increasingly real-time, highly concurrent applications (read: wearables sending
tons of data back to the mothership), I think this is an area in which it is
worth building expertise. Put another way, I believe levels of concurrency that
were once only the concern of massive corporate giants will become a concern for
more wearable/IoT startups.

In addition to all this, Elixir was created by Jos&eacute; Valim, a basically
kick-ass developer who co-founded his own consultancy, was the core developer of
the Devise authentication gem (and who knows what else), and just generally eats
Ruby and code for breakfast. What this means for Elixir is that it is very much
influenced by Ruby's syntax, making my own transition (as a Ruby developer) that
much more enjoyable. Furthermore, Valim clearly knows how to carry a project, so
Elixir is very likely to be well-maintained.

## The Jourlang Begins
I remembered reading over on Hacker News about a book on Erlang with a
particularly clever title: ["Learn You Some Erlang For Great
Good"](http://learnyousomeerlang.com/) (written in the spirit of "Learn You a
Haskell For Great Good" SUCH FUNNY).

<div class="image-wrapper">
  <img src="/articles/IMG_1100.PNG"
       alt="A mustachioed octopus on the cover of 'Learn You Some Erlang For Great Good', the riveting tale of a tremendously talented mollusk functional programming practitioner" />
  <blockquote>
    A mustachioed octopus on the cover of 'Learn You Some Erlang For Great Good',
    the riveting tale of a tremendously talented mollusk functional programming
    practitioner
  </blockquote>
</div>

At the time, Erlang didn't really mean much to me, other than I knew there was
some vague connection between Elixir and Erlang, and less-so between Haskell and
Erlang. BUT since I had always wanted to Crush It Hard with FP, I made a mental
note to go back to the book when the time was right. After reading about the
Phoenix API Mega Hi-Score, I decided the time was indeed right.

As of this post, I am about a quarter of the way through the book, having
covered syntax, types, and recursion. With some justification for learning
Elixir specifically, I will breaking out my experience with Erlang into upcoming
blog posts. Specifically, I will cover how I set up my machine for Erlang and
Elixir development (tools, editor plugins, etc.), some thoughts on pros, cons,
and oddities of the language and framework, and finally a walkthrough of a
yet-to-be-determined First Application in Elixir. Assuming, of course, that I
don't fall into some kind of [infinite recursion](/2015/02/07/drinking-the-koolixir.html).
