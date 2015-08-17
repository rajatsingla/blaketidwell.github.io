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
SkyNet becomes sentient. We will, however, set up tools and a workflow for
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

<div class="image-wrapper">
  <img alt="Double digit user acquisition rates got me eatin dis here cash money."
       src="/images/eating_munniez.jpg" />
  <blockquote>
    Sorry, got a little carried away there...nom nom nom...
  </blockquote>
</div>


Let's get our project set up to implement and test these simple features.

## Putting Stuff Together

Start out by laying down some fresh Rails to start driving this train into the
future, and watch the sweet, sweet bundles download from the ether:

```
rails new cash_cats
```

### Installing the Test Suite

Let's first switch everything over to RSpec by adding a few gems:

```ruby
# Gemfile
group :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
end
```

From the command-line, we bundle, set up RSpec, and remove the (now) unused
`test` directory:

```bash
$ bundle
$ rails generate rspec:install
$ rm -rf test
```

At this point, if you run `rake` from the root of the project, you should see
some output indicating that RSpec is running, albeit with `0 examples` as the
result. One last bit of cleanup before we move on is to update the generators in
the application config so that they use RSpec instead of Minitest:

```ruby
# config/application.rb
module CashCats
  class Application < Rails::Application
    # ...a bunch of other stuff.
    config.generators do |g|
      g.hidden_namespaces << "test_unit"
      g.test_framework :rspec, fixture: false
      g.fixture_replacement :factory_girl
    end
    # blah blah blah more stuff.
  end
end
```

Now, when we run a generator that creates a test, it will use RSpec and
FactoryGirl instead of Minitest and fixtures. Additionally, we hide the
`test_unit` generator namespace so that it doesn't muddy up the help menu output
when `rails g` is run without any arguments.

### Speed Up This Train

### Write out the specs

## Drive Straight to Town on Rails of Ruby
