require 'yaml'
require 'hashie'

class Blogbrid
  class Page
    @base_path = 'content/pages'

    attr_reader :file, :path

    def initialize(path, base_path = self.class.base_path)
      @path = path
      @file = File.expand_path(path, base_path)
    end

    def body
      content[:body]
    end

    def data
      content[:data]
    end

    def exist?
      File.exist?(@file)
    end

    def name
      @name ||= File.basename(@path, '.*')
    end

    def title
      @title ||= data.title || name
    end

    def url
      @url ||= "/#{@path.sub(/\.md$/, '')}/"
    end

    def self.url_to_filename(url)
      # '/path/to/name/' => 'path/to/name.md'
      path = url.sub(%r{^/}, '').sub(%r{/$}, '')
      "#{path}.md"
    end

    def self.base_path
      @base_path
    end

    def self.base_path=(path)
      @base_path = path
    end

    private

    def content
      @content ||= parse_front_matter
    end

    def parse_front_matter
      file = File.read(@file)
      if file =~ /\A(---\s*\n.*?\n?)^((---|\.\.\.)\s*$\n?)/m
        {body: $POSTMATCH, data: Hashie::Mash.new(YAML.load($1))}
      else
        {body: file, data: nil}
      end
    end
  end
end
