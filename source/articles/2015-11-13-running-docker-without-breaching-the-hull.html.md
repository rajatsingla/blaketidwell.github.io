---
title: Running Rails On Docker Without Breaching the Hull
date: 2015-11-13 07:56 UTC
tags: docker, containers, hull-integrity, security
---

As part of my exploration of a minimum set of devops tools, I've been learning
how to stack containers full of Rails apps onto the Docker.  There are plenty of
examples of how to get started with Rails and Postgres on Docker, even one [from
the whale's mouth](https://docs.docker.com/compose/rails/), as it were. Working
from this example, it was pretty clear to me that one of Docker's major
strengths is that it makes it _really, really easy_ to get something running
with a minimum of fuss; it took all of about a half day to learn enough Docker
to hoist anchor, and even tweak a few things to my liking. One thing kept nagging
me about the Docker example, though, and that was a warning from `bundler` when
running `docker-compose`.

READMORE

## Oh Noes, a Warnthing?!

> `Don't run Bundler as root.`

Running `bundler` in this way strikes me as a needless security risk (why sudo
when you can suDON'T PRIVILEGE ESCALATION EXPLOIT YOURSELF), so I set about
modifying the example file to

1. shut it up and
1. learn some more about Docker.

I'll admit, depending upon your tolerance for warning messages, this kind of
minutiae may not even show up on your radar. And let me be clear that **this
post is not a knock against the Docker team** for this "flaw" in the example;
they're doing absolutely amazing stuff by building Docker in the first place and
they [absolutely give a
damn](https://blog.docker.com/2015/05/understanding-docker-security-and-best-practices/)
[about security](https://github.com/docker/docker/issues/13490). As mentioned in
the intro, this is more about learning Docker by addressing this (arguably
security-oriented) warning.

## The :egg:sample From the Dockermentation

For reference, the example Dockerfile looks like so:

```

FROM ruby:2.2.0
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev
RUN mkdir /myapp
WORKDIR /myapp
ADD Gemfile /myapp/Gemfile
ADD Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
ADD . /myapp
```

Let's unpack this a bit before moving on (for a more in-depth explanation, head
over to the [docs themselves](https://docs.docker.com/compose/rails/)):

1. Pull the base image for Ruby 2.2.0.
1. Update and install some packages with `apt-get`.
1. Make a new directory and work out of it.
1. Copy over a seed Gemfile(.lock).
1. Install with bundler (**THE OFFENDING LINE :scream:**)
1. "Bake" the now-bundled app into the container.

## Look At Me I Can Docker Too

[I Will Do It Nine Times](https://youtu.be/ln5Ar5aHDYM?t=12s). Okay, actually
only one time I will do it:

```

FROM ruby:2.2.3
RUN apt-get update -qq
RUN apt-get install -y build-essential libpq-dev

RUN mkdir /app
WORKDIR /app
ADD . /app

RUN useradd -ms /bin/bash rails
RUN chown -R rails:rails .

USER rails

ENV GEM_HOME /home/rails/.gems
RUN gem install bundler
RUN bundle
```

How is this more different than before, hmm?

1. A `rails` user is created and used to install gems with bundler and then run
   the application. No More Sudo Bundle:no_good:. That being said, this still needs to
   be updated to include something like Nginx as a proxy to get around the
   limitation of being unable to start Rails on port 80 without `sudo`. To be
   addressed...
1. The Rails app is "newed" prior to spinning up the app for the first time.
   This avoids the need to make the placeholder Gemfile as in the Docker
   example, and IMHO, feels like it more clearly separates the containerization
   step from the source code implementation step.

# Dockered
And there you have it. With a few minor tweaks to the Dockerfile, bundler has
been silenced, and the deployment configuration uses a dedicated, unprivileged
user for managing package installation and starting the relevant app. What's
more is that it accomplishes this while both leveraging the base Ruby image on
Docker Hub and avoiding the overhead of RVM or rbenv. All in all, this kind of
very particular goal really helped to clarify my understanding of Docker, from
permissions all the way to source code copying.  Not least of all, this leaves
me feeling a bit more at-ease, knowing that there is one less way to succumb to
some as-yet unknown vulnerability in Docker whilst running errant `sudo`
commands in Dockerfiles.

