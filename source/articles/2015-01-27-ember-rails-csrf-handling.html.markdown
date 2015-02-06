---
title: Ember Rails CSRF Handling
date: 2015-01-27 07:24 UTC
tags: emberjs,rails,ruby,technical,quickread,dragons
---

To get some more practice with my new Vim + Tmux setup (a topic unto itself, I might add), I ran back through the Ember JS "Getting Started" guide and wired it to a simple Rails back-end. However, I wanted to adhere to a strict SPA/API architecture, and ran into some CSRF issues as a result.

READMORE

## The Challenge

To protect against CSRF attacks, Rails generates an authenticity token for each form submission. If the token isn't present, the request is rejected. This works great for apps that are served up by the Rails app (since said token is available as a meta-tag on the hosting page), but things start to get a little trickier when your single-page app is decoupled from the Rails server (say with something like an S3-oriented deployment, or Divshot). In this scenario, you have to write some custom glue code to ensure the SPA is able to retrieve and then provide the token on each request, and, likewise, to ensure the Rails app checks for it in the correct way. There are plenty of SO threads and blog posts available covering CSRF handling for SPAs, but they all seem to focus on Angular JS, and even then, only cover part of the total solution. I wound up stitching together resources from a handful of locations to get a CSRF fix for Ember that I was satisfied with.

## Server Side Glue
The Angular JS docs make a [suggestion](https://docs.angularjs.org/api/ng/service/$http#cross-site-request-forgery-xsrf-protection) which prompted [this response posted to SO by HyungYuHei](http://stackoverflow.com/questions/14734243/rails-csrf-protection-angular-js-protect-from-forgery-makes-me-to-log-out-on/15761835#15761835). I've included the relevant snippet below for completeness:

```ruby
# app/controllers/application_controller.rb

# Turn on request forgery protection
protect_from_forgery

after_filter :set_csrf_cookie

def set_csrf_cookie
  cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
end

protected

  # In Rails 4.2 and above
  def verified_request?
    super || valid_authenticity_token?(session, request.headers['X-XSRF-TOKEN'])
  end
```

This sets the authenticity token as a cookie, and then checks for it in the headers on every request. The snippet worked flawlessly, and provided a great starting point for integrating the front-end of this exercise and Everything Was Amazing&trade;.

## Front End Goop

The next step is to configure the Ember app to snag the authenticity token out of the cookies and send it with each API request. Unfortunately, as mentioned, the SO thread only covers Angular JS. This left me to dig through the Ember JS docs for a bit, before coming upon [this entry](http://emberjs.com/api/data/classes/DS.RESTAdapter.html). Toward the bottom is a section on customizing request headers. To this effect, I added the following to `adapters/application.js`:


```js
export default DS.ActiveModelAdapter.extend({
  namespace: 'api',
  headers: function() {
    return {
      "X-XSRF-TOKEN": Ember.get(document.cookie.match(/XSRF\-TOKEN\=([^;]*)/), "1")
    }
  }.property().volatile()
});
```

## Ultimate Victory

So, la la la, everything was great, and I rode off into the sunset, OKAY BUT NO, SERIOUSLY, why was I still getting `Invalid Authenticity Token: U SUCK` error messages?

### Okay, So Not So Ultimate

And thank goodness, because this wouldn't be much of a blog post without a plot twist at the end where The Developer has to wrestle a flaming error message to the ground with their bare hands. So, I mounted my trusty steed or laptop or whatever, and like, opened up my Developer Tools in Chrome. And I was like "Show thy Lizard Face, that I may smite it." And The Foul Cookie Dragon of the Resources Tab was all like:

```dragon
R8xp3FN5QrlQM12GLb28f6%2BtPsYkcYYNfRsYQ3q5ryq%2Bx387750%2BHI%2FCxVUrjZDCiX4eIL63V4BF4NcA7eLddg%3D%3D
```

And I said unto the dragon, "Wow, you must be blast at parties" or maybe it was like "Now Dragon, use your words." but actually I was like WAIT A MINUTE DRAGON what's with all that URL encoded mess you said toward the end there? that seems pretty important, I bet. And wouldn't you know it, that dragon solved the mystery. So I changed:

```js
return {
  "X-XSRF-TOKEN": Ember.get(document.cookie.match(/XSRF\-TOKEN\=([^;]*)/), "1")
}
```
to...

```js
return {
  "X-XSRF-TOKEN": decodeURIComponent(Ember.get(document.cookie.match(/XSRF\-TOKEN\=([^;]*)/), "1"))
}
```
**YES! decodeURIComponent!**

And the dragon was all like, "Geez, dude, you have no idea how hard is to talk in percent signs and stuff all the time, thanks for URI decoding me." And there was peace and API integration throughout the land FOREVER AND EVER HAPPILY EVER AFTER.

# THE END
