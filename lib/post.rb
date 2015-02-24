require_relative 'content'

class Blogbrid
  class Post < Content
    def date
      @date ||= Date.new(*split_filename[0, 3].map(&:to_i))
    end

    def name
      @name ||= split_filename[3]
    end

    private

    def split_filename
      @split_filename ||= File.basename(@path, '.*').split('-', 4)
    end
  end
end
