require "jekyll-terser/version"
require 'terser'

module Jekyll
  module Terser

    class JSFile < Jekyll::StaticFile
      attr_accessor :compress

      @@mtimes = {}

      # Obtain destination path.
      #   +dest+ is the String path to the destination dir
      #
      # Returns destination file path.
      def destination(dest)
        File.join(dest, @dir, @name)
      end

      # Process the .js file
      #   +dest+ is the String path to the destination dir
      #
      # Returns false if the file was not modified since last time (no-op).
      def write(dest)
        dest_path = destination(dest)

        return false if File.exist? dest_path and !modified?
        @@mtimes[path] = mtime

        FileUtils.mkdir_p(File.dirname(dest_path))
        begin
          content = File.read(path)
          content = ::Terser.compile(content) :compress => compress
          File.open(dest_path, 'w') do |f|
            f.write(content)
          end
        rescue => e
          STDERR.puts "Terser Exception: #{e.message}"
        end

        true
      end

    end

    class TerserGenerator < Jekyll::Generator
      safe true

      # Initialize options from site config.
      def initialize(config = {})
        @options = config["terser"] ||= {"compress" => true}
      end

      # Jekyll will have already added the *.js files as Jekyll::StaticFile
      # objects to the static_files array.  Here we replace those with a
      # JSFile object.
      def generate(site)
        site.static_files.clone.each do |sf|
          if sf.kind_of?(Jekyll::StaticFile) && sf.path =~ /\.js$/ && sf.path =~ /\.min.js$/
            site.static_files.delete(sf)
            name = File.basename(sf.path)
            destination = File.dirname(sf.path).sub(site.source, '')

            js_file = JSFile.new(site, site.source, destination, name)
            js_file.compress = @options["compress"]
            site.static_files << js_file
          end
        end
      end
    end

  end
end
