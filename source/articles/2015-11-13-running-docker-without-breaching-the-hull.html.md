---
title: Running Docker Without Breaching the Hull
date: 2015-11-13 07:56 UTC
tags: docker, containers, hull-integrity, security
---

Docker is the Coolest New Awesome on the market, allowing anyone with a terminal
and a `docker build` to stack containers full of apps and load their server
fleet with endless logistics analogies. In other words, one of Docker's major
strengths is that it makes it _really, really easy_ to get up and running and
deploy a working app with a minimum of fuss. Worryingly, after reading through
dozens of pages of the documentation, analyzing example repos, and bloggonizing
over blogs, I noticed that not much was said in the way of security best
practices. Namely, all of the Rails examples nonchalantly installed and run
Bundler as the root user.

READMORE

Puppies. :dog:
