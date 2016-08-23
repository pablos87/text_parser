require_relative 'paragraph'

class Article
  attr_accessor :title, :body, :paragraphs, :sections

  def initialize(title: '', body: '', paragraphs: [], sections: [])
    self.title = title
    self.body = body
    self.paragraphs = paragraphs
    self.sections = sections
  end
  
  def to_s
    output = []
    output << [title, body].join(' ')
    output += sections
    output += paragraphs
    output.join("\n")
  end
end
