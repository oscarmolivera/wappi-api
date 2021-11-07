class Post
  attr_reader :id, :title, :body

  def initialize(data)
    @id = data[:id]
    @title = data[:title].capitalize
    @body = data[:body]
  end
end
