require_relative 'content'

class Post < Content
  def name
    @name ||= split_filename[3]
  end

  private

  def split_filename
    @split_filename ||= File.basename(@path, '.*').split('-', 4)
  end
end
