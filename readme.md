Terser for Jekyll
===============

This gem provides a [Jekyll](http://github.com/mojombo/jekyll) converter for [Terser](https://github.com/terser/terser).

Basic Setup
-----------
Install the gem:

    [sudo] gem install jekyll-terser

In a plugin file within your Jekyll project's _plugins directory:

    # _plugins/my-plugin.rb
    require "jekyll-terser"

Alternatively, add a configuration option in `_config.yml`:

    gems: ['jekyll-terser']

.js files anywhere in your Jekyll project's directory will be processed.

Bundler Setup
-------------
Already using bundler to manage gems for your Jekyll project?  Then just add

    gem "jekyll-terser"

to your gemfile and create the following plugin in your projects _plugins
directory.  I've called mine bundler.rb.  This will automatically require all
of the gems specified in your Gemfile.

    # _plugins/bundler.rb
    require "rubygems"
    require "bundler/setup"
    Bundler.require(:default)

Credit
------

Leverages [terser-ruby](https://github.com/ahorek/terser-ruby) ruby Terser wrapper by [ahorek](https://github.com/ahorek)

Based on [jekyll-less](https://github.com/zroger/jekyll-less) by [zroger](https://github.com/zroger), originally based on this [gist](https://gist.github.com/760265) by
[joshbrown](https://github.com/joshbrown).
