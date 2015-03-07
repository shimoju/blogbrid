require_relative 'page'

class Blogbrid
  class Post < Page
    @base_path = 'content/posts'

    def date
      @date ||= Date.new(*split_filename[0, 3].map(&:to_i))
    end

    def name
      @name ||= split_filename[3]
    end

    def url
      @url ||= date.strftime("/%Y/%m/%d/#{name}/")
    end

    def self.url_to_filename(url)
      # '/2015/02/24/hello-world/' => '2015-02-24-hello-world.md'
      year, month, day, name = url.split('/').compact.reject(&:empty?)
      "#{year}-#{month}-#{day}-#{name}.md"
    end

    private

    def split_filename
      @split_filename ||= File.basename(@path, '.*').split('-', 4)
    end
  end
end
