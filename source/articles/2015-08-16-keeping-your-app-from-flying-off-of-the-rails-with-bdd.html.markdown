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


Let's get our project set up to test and implement these simple features.

## Putting Stuff Together

Start out by laying down some fresh Rails to start driving this train into the
future, and watch the sweet, sweet bundles download from the ether:

```
rails new cash_cats
```

### Installing the Test Suite

Let's first switch everything over to RSpec by adding a few gems, and also add
Capybara Webkit for Javascript and browser testing:

```ruby
# Gemfile
group :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  # For dummy data
  gem 'faker'
  gem 'database_cleaner'
  gem 'capybara-webkit'
end
```

From the command-line, we bundle, set up RSpec, and remove the (now) unused
`test` directory:

```bash
$ bundle
$ rails generate rspec:install
$ rm -rf test
```

Next, modify the Rails spec helper to use both DatabaseCleaner and Capybara
Webkit. The boilerplate for Database Cleaner shown below can be found
[in the repo README](https://github.com/DatabaseCleaner/database_cleaner#rspec-with-capybara-example):

```ruby
# spec/rails_helper.rb
# ...

Capybara.javascript_driver = :webkit

# ...

RSpec.configure do |config|
  # Other stuff.
  config.use_transactional_fixtures = false

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do |example|
    DatabaseCleaner.strategy= example.metadata[:js] ? :truncation : :transaction
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
  # Maybe some more other stuff.
end
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

### Drive Straight to Town on Rails of Ruby

To test-drive this puppy, we will write out a handful of feature specs, then
work on getting them to pass. A method I have found helpful when working with a
fairly well-defined set of features is to write out a number of them ahead of
time using placeholder specs. This acts both as a todo list of sorts, as well as
an indicator of progress. I also find that it  helps me to keep a high-level
picture of the current application component in mind. Your mileage may vary,
etc., etc., `[insert other disclaimers and anti-troll bait here]`.

Let's make two feature groups:

```bash
$ rails g rspec:feature login_and_authentication
$ rails g rspec:feature recording_munny
```

...and add a handful of specs to them:

```ruby
# spec/features/login_and_authentication
require 'rails_helper'

RSpec.feature "Login And Authentication", type: :feature do
  it 'can register for an account'

  context 'after creating an account' do
    it 'can log into my account'
  end
end

# spec/features/recording_munnies
require 'rails_helper'

RSpec.feature "Recording Munnies", type: :feature do
  context 'when logged in' do
    it 'can register for an account'
  end
end

```

Running `rake` now should display three pending specs.

### Speed Up This Train

Running `rake` manually is great and all, but wouldn't it be more awesomer if we
could automate that a bit? Let's add `guard-rspec` to the mix to do just that:

```ruby
# Gemfile
group :development, :test do
  # ...
  gem 'guard'
  gem 'guard-rspec'
  # ...
end
```

Now, bundle, install the Guard gem, and start it up:

```bash
$ bundle
$ bundle exec guard init
$ bundle exec guard
```

If all goes as expected, you should now be able to save a spec file, and trigger
a test run for only that file. This works only for files suffixed with `_spec`,
which is the default for generated files. Give it a try by opening up one of the
two feature spec files and saving them. You should see the specs in that file
running in automatically. There are a number of other settings that can be
tweaked in Guard to make it focus failed tests, use Spring, etc., but we will
skip those features for the sake of this walkthrough.

