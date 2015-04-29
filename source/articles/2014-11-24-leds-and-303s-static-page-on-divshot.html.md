---
title: LEDs and 303s Static Page on Divshot
date: 2014-11-24 00:53 UTC
tags:
  - technical
  - how-to
  - ruby
  - deployment
disqus_identifier: /2014-11-24-leds-and-303s-static-page-on-divshot.html
---

Took some time to spin up a home page for my music project this weekend, and decided it would be a great opportunity to not only level up my Middleman and design chops, but also try out a new (*to me anyway*) static hosting service called Divshot.

READMORE

# The Site

I&apos;ve produced electronic tracks for over a decade now (going all the way back to Fruityloops 1.0). My current musical project, [LEDs and 303s](http://www.ledsand303s.com) has been long overdue for its own HQ. Building a quick landing page for this purpose has not only given me renewed motivation to get back to writing music, but also provides another outlet for some design and front-end hackery.

<a href="http://www.ledsand303s.com"><img alt="LEDs and 303s Home Page" src="/images/ledshome.png" /></a>

Since I&apos;ve been so happy with Middleman for this site, I chose to stick with it for the L303 home page. To keep things simple, it leverages the HTML5 Boilerplate template:

```bash
  $ middleman init ledsand303s.com --template=html5
```

All other CSS was handcoded to keep the CSS size down. As a comparison, this site&apos;s primary CSS file comes in at 46.5KB, while *LEDs and 303s* is a piddly 7.4KB. There are other differences in approach between the two stylesheets and this is arguably negligible, but the relative size is still telling. This isn&apos;t to say I would use this approach for every site, but it is nice to arrive back at this point from a couple years of jumping straight to Bootstrap or Foundation to kick off a site. I also modified the root CSS file slightly to combine all CSS into single file. Instead of using `import` statements at the top of `main.css`, I opted for the following:

```scss
/*
 *= require normalize
 *= require main
*/
```

# Background Effect
For Le Coolness++, I decided to add a background effect. Actually, it was because the background loading into place one row of pixels at a time was sort of a buzzkill, but same diff. I manage Javascript dependencies using [Bower](http://bower.io/). The only configuration tweak of note here is the addition of a `.bowerrc` file at the root of the project containing the following:

```json
{
  "directory" : "source/js/bower_components"
}
```

This installs all of the Bower packages into a location where they can be easily referenced from the Middleman asset pipeline. This is not strictly necessary, but it does prevent coming back in a few months and being all like:

```coffee
#= require ../../../why_isnt_this_in_the_assets_dir/sulk
```

You&apos;ll also want to add `bower_components` to your `.gitignore`, to be sure. [waitForImages](https://github.com/alexanderdickson/waitForImages) is used to detect when the background image is ready, and combined with a smattering of CSS and a simple JS function for the Full Effect:

```scss
$bg-image-tiny: image-path("fall-in-to-the-gap-tiny.jpeg");

// Rest of the CSS here...

.background {
  position: fixed;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  background-image: url('#{$bg-image-tiny}');
  background-size: cover;
  background-position: center;
  opacity: 0;
  @include single-transition(opacity, 12s, ease-in);
  &.show {
    opacity: 0.7;
  }
}
```

You may notice the background is &#8220;mobile-first&#8221; , i.e. the smallest possible image is used as the default, and media queries are used to display images of increasingly higher resolution.

Coffeescript to display the background when it is ready is as follows:

```coffee
#= require bower_components/waitForImages/dist/jquery.waitforimages.min

$ ->
  $('.background').waitForImages ->
    $(@).addClass 'show'
```

# Divshot
[Divshot](https://divshot.com/) makes it super simple to deploy static sites to their managed hosting platform. You should follow their setup instructions to install the CLI utility, and then log in from the command line. Once that&apos;s done, run `divshot init`, and when prompted to set the root for the project use `./build`. The default values can be used for all of the other options. With this done, run `divshot push`, and *poof* a website. Divshot goes so far as to offer development, staging, and production instances. If your project benefits from this, you can &#8220;promote&#8221; your app by running `divshot promote [source_environment] [target_environment]`. I only use the development and production instances for *LEDs and 303s*, but even that&apos;s helpful for avoiding blowing up the live site with some unexpected configuration issue.

# Conclusion
This workflow is definitely my new go-to for static sites. There&apos;s never been a better time to get to work on my Cats In Space visualization project.