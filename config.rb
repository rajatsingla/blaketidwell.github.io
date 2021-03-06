###
# Blog settings
###

activate :emoji,  dir: '/images/emoji'

# Time.zone = 'UTC'

activate :blog do |blog|
  # This will add a prefix to all links, template references and source paths
  # blog.prefix = 'blog'

  # blog.permalink = "{year}/{month}/{day}/{title}.html"
  # Matcher for blog source files
  blog.sources = "articles/{year}-{month}-{day}-{title}.html"
  # blog.taglink = "tags/{tag}.html"
  blog.layout = 'article'
  # blog.summary_separator = /(READMORE)/
  # blog.summary_length = 250
  # blog.year_link = "{year}.html"
  # blog.month_link = "{year}/{month}.html"
  # blog.day_link = "{year}/{month}/{day}.html"
  # blog.default_extension = ".markdown"

  blog.tag_template = 'tag.html'
  blog.calendar_template = 'calendar.html'

  # Enable pagination
  # blog.paginate = true
  # blog.per_page = 10
  # blog.page_link = "page/{num}"
end

page '/feed.xml', layout: false

###
# Compass
###

# Change Compass configuration
compass_config do |config|
  config.additional_import_paths = [
    '../bower_components/foundation/scss',
    '../bower_components/foundation-icon-fonts',
    '../bower_components/js-emoji'
  ]
end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page '/path/to/file.html', layout: false
#
# With alternative layout
# page '/path/to/file.html', layout: :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page '/admin/*'
# end

# Proxy pages (http://middlemanapp.com/dynamic-pages/)
# proxy '/this-page-has-no-template.html', '/template-file.html', locals: {
#  which_fake_page: 'Rendering a fake page with a local variable' }

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
activate :livereload

activate :imageoptim do |image_optim|
  image_optim.pngout_options = false # Should disable pngout
end

activate :syntax

set :url_root, 'http://www.blaketidwell.com'

activate :search_engine_sitemap

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     'Helping'
#   end
# end
set :layout_dir, ''

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

set :markdown_engine, :redcarpet
set :markdown, fenced_code_blocks: true, smartypants: true

activate :deploy do |deploy|
  deploy.build_before = true # default: false
  deploy.method = :git
  deploy.branch = 'master'
end

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  activate :gzip

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_prefix, '/Content/images/'
  activate :disqus do |d|
    # using a special shortname
    d.shortname = 'blaketidwell'
    d.root_url = root_url_with_port
  end
end

set :protocol, 'http://'
set :host, 'www.blaketidwell.com'
set :port, 80

helpers do
  def root_url
    protocol + host
  end

  def root_url_with_port
    [root_url, optional_port].compact.join(':')
  end

  def host_with_port
    [host, optional_port].compact.join(':')
  end

  def optional_port
    port unless port.to_i == 80
  end

  def image_url(source)
    protocol + host_with_port + image_path(source)
  end
end

configure :development do
  begin
    if Middleman.const_get 'PreviewServer'
      set :host, Middleman::PreviewServer.host
      set :port, Middleman::PreviewServer.port

      activate :disqus do |d|
        # using a special shortname
        d.shortname = 'btlocal'
        d.root_url = root_url_with_port
      end
      # Used for generating absolute URLs
    end
  rescue NameError
    # Whoops.
  end
end
