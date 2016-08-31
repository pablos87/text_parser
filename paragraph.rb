class Paragraph
  attr_accessor :title, :body

  def initialize(params)
    self.title = params[:title]
    self.body = params[:body]
  end

  def to_s
    "\t#{title} #{body}"
  end
end
