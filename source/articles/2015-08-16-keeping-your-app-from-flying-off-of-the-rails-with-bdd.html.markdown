---
title: Keeping Your App from Flying Off of the Rails with BDD
date: 2015-08-16 23:59 UTC
tags:
---

_The following blarg assumes working knowledge of user story mapping, user
stories, and other such techniques of Le M&eacute;thode Agile._

Through a nigh omniscient understanding of the needs of The Cash Cat, your
product team has painstakingly produced a sublime list of :sparkles:User
Stories:sparkles:, seemingly from thin air. Trusting the wisdom of the Ancients,
the development team has chosen to ride the Rails of Ruby forward into
user-acquisition glory. How can we ensure that their vision of the app is
executed flawlessly? Well, we can't, and if you do come up with a way to write
literally bug-free code, please promptly write an AI and cash your check before
SkyNet becomes sentient. What we will do is set up tools and a workflow for
building the app using behavior-driven development: Rails, RSpec, Capybara,
FactoryGirl, and Guard, to be precise.

READMORE

## So What Are We Building, Exactly?

Mantra-like, the steady rhythm of _"As a Cash Cat"_ droning in
your mind's eye, you mentally intone The Stories in preparation for your
upcoming sprint:

> As a Cash Cat, so that I can claim my rightful place on the Interwebs, I can
> sign up for a Cash Cats account when I first visit the site.
>
> As a Cash Cat, so that I can recall my mind-numbingly vast sums of cash, I can
> log into my Cash Cat account.
>
> As a Cash Cat, so that I can show off my wads of dough, I can record my cash
> when logged in.
>
> As a Cash Cat...
>
> As a Cash Cat...
>
> As a Cash Cat...

<img alt="Double digit user acquisition rates got me eatin dis here cash money."
       src="/images/eating_munniez.jpg" />

Let's get our project set up to implement and test these simple features.

## Putting Stuff Together

1. Start a new project.
1. Install and configure the test suite.
1. Write out the specs.
1. Make each one work.

## Drive Straight to Town on Rails of Ruby
