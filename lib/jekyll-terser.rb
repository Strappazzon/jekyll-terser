require 'jekyll'
require 'terser'

module Jekyll
  module Terser
    class ModTime
      @mtimes = {}

      class << self
        attr_reader :mtimes
      end

      class << self
        attr_writer :mtimes
      end
    end

    class JSFile < Jekyll::StaticFile
      def initialize(site, base, dir, name, terser = nil)
        super(site, base, dir, name)

        @site   = site
        @base   = base
        @dir    = dir
        @name   = name
        options = site.config['terser'] || {} if terser.nil?
        @terser = terser || ::Terser.new(options.transform_keys(&:to_sym))
      end

      def destination(dest)
        File.join(dest, @dir, @name)
      end

      def write(dest)
        dest_path = destination(dest)

        return false if File.exist?(dest_path) && !modified?

        ModTime.mtimes[path] = mtime

        FileUtils.mkdir_p(File.dirname(dest_path))

        begin
          content = File.read(path)
          content = @terser.compile(content)

          File.write(dest_path, content)
        rescue StandardError => e
          Jekyll.logger.warn 'Terser:', e.message.to_s
        end

        return true
      end
    end

    class TerserGenerator < Jekyll::Generator
      def initialize(config = {})
        super

        @options = config['terser'] || {}
        @terser = ::Terser.new(@options.transform_keys(&:to_sym))
      end

      def generate(site)
        site.static_files.clone.each do |f|
          next unless f.is_a?(Jekyll::StaticFile) && f.path.match?(/\.js$/) && !f.path.end_with?('.min.js')

          Jekyll.logger.info 'Terser:', "Minifying #{f.path}"
          site.static_files.delete(f)

          name        = File.basename(f.path)
          destination = File.dirname(f.path).sub(site.source, '')
          js_file     = JSFile.new(site, site.source, destination, name, @terser)

          site.static_files << js_file
        end
      end
    end
  end
end
