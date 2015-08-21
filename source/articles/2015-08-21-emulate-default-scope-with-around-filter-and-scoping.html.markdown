---
title: Emulate Default Scope with Around Filter and Scoping
date: 2015-08-21 03:04 UTC
tags: technical, ruby, rails, how-to, quickread
---

We all know that [`default_scope` is
evil](http://rails-bestpractices.com/posts/2013/06/15/default_scope-is-evil/).
But sometimes, you really _do_ want to make sure that a condition is *almost*
always applied to the queries for a particular model. Draft vs. published posts,
approved vs. unapproved content, soft deletes, cat videos vs. not-cat videos,
etc., etc.  What's a well-behaved Rails developer to do?  Recently, I
encountered this exact issue on a project I was working on, and was not
satisfied with the choice between Being Evil &agrave; la `default_scope` or
being repetitive and scattering `where(whatever: true)` conditions throughout
the code.  After some searching, I came across a combination of methods that
accomplishes essentially the same goal without all of the bizarre side effects
of `default_scope`.

READMORE

## Le Hypothetical Situation

Imagine that we want to build a blogging platform in Rails with the usual
draft-before-publish workflow. Basically, we want to make sure that drafts only
ever show up when an admin is logged in. The first solution that comes to mind
for a problem like this is to chuck the condition into a `default_scope` on your
model:

```ruby
class Post < ActiveRecord::Base
  default_scope where(draft: false)
end
```

I won't rehash the challenges of using `default_scope` in this post; give the
Rails Best Practices link at the top of this post a good read and you should at
least get the general idea that there are a lot of weird things to account for
with this approach.

## Le Alternative Different

Enter `after_filter` and `scoping`. Below is a simple example of using this
approach in the `ApplicationController` to accomplish the same draft filtering:

```ruby
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  around_filter :scope_to_published

  private

  def scope_to_published
    Post.where(draft: false).scoping do
      yield
    end
  end
end
```

This results in the `Post` model being "globally" scoped before running the rest
of the controller method. Since it happens in the `ApplicationController`, it
will apply to all subclassed controllers. (Worth noting is that `where(draft:
false)` can of course be converted to an equivalent scope named `published` or
some such.) Using this approach, and some thoughtful placement in the controller
hieararchy, it is possible to increase or decrease the granularity of a
"default" condition. It is easy to imagine having an `AdminController` that does
not inherit from `ApplicationController` and would therefore not be subject to
this global scoping. Alternatively, a `skip_filter` directive could be added
only to those controllers where this scoping should not apply. In the direction
of more specificity, the `around_filter` could be moved further down the class
hierarchy and explicitly applied to the `PostsController` or any number of
related controllers.

# Un Caveat

As a disclaimer, I have not benchmarked the effect this might have at the
`ApplicationController` level. I would guess that in the best case, it should
incur no more performance overhead than an explicit `where` clause, and in
the worst case, it would incur a trivial impact more than made up for by
conciseness. Can't say for certain without running benchmarks, but I invite any
interested readers to share any findings or insights they might have in this
regard.
