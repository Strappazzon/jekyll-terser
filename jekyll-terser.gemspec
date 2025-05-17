Gem::Specification.new do |spec|
  spec.name          = 'jekyll-terser'
  spec.version       = '1.0.0'
  spec.authors       = ['Alberto Strappazzon']
  spec.summary       = 'Jekyll support for Terser.'
  spec.description   = 'Jekyll support for Terser: compress and mangle JS files.'
  spec.license       = 'MIT'

  raise 'RubyGems 2.0 or newer is required.' unless spec.respond_to?(:metadata)

  spec.metadata['source_code_uri'] = 'https://github.com/Strappazzon/jekyll-terser'
  spec.metadata['changelog_uri']   = 'https://github.com/Strappazzon/jekyll-terser/blob/master/CHANGELOG.md'

  spec.files                 = [*Dir['lib/**/*.rb'], 'LICENSE.txt']
  spec.require_paths         = ['lib']
  spec.required_ruby_version = '>= 3.4.2'

  spec.add_dependency 'jekyll', '~> 4.4'
  spec.add_dependency 'terser', '~> 1.2'
end
