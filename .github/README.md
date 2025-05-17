<!-- markdownlint-disable MD033 MD041 -->
<div align="center">
  <img width="96" src="./assets/rubygems_logo.png" alt="RubyGems Logo">
</div>

<div align="center">
  <strong>jekyll-terser</strong>
</div>

<p align="center">
  <em>Jekyll support for Terser</em>
</p>
<!-- markdownlint-enable MD033 MD041 -->

## Installation

Add one of these lines to your `Gemfile`:

```rb
# always use the latest version
gem 'jekyll-terser'

# use pessimistic lock
gem 'jekyll-terser', '~> 1.0'

# fetch gem from git
gem 'jekyll-terser', git: 'https://github.com/Strappazzon/jekyll-terser.git', tag: '1.0.0'
```

Then execute `bundle install` to install the Gem.

## Getting Started

No additional steps are required.
All JS files inside the destination directory are overwritten with the output of Terser.

You can also specify the options inside your configuration:

```yaml
jekyll-terser:
  terser_opts:
    compress: {}
    mangle: {}
    parse: {}
```

All available options are available on [Terser Docs](https://terser.org/docs/options/).

You can also specify that Terser should only work in production mode:

```yaml
jekyll-terser:
  only_production: true
```
