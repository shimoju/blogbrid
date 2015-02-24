require 'yaml'
require 'hashie'

class Content
  def initialize(path)
    @path = path
  end

  def body
    content[:body]
  end

  def data
    content[:data]
  end

  def name
    @name ||= File.basename(@path, '.*')
  end

  def title
    @title ||= data.title || name
  end

  private

  def content
    @content ||= parse_front_matter
  end

  def parse_front_matter
    file = File.read(@path)
    if file =~ /\A(---\s*\n.*?\n?)^((---|\.\.\.)\s*$\n?)/m
      {body: $POSTMATCH, data: Hashie::Mash.new(YAML.load($1))}
    else
      {body: file, data: nil}
    end
  end
end
