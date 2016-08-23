require_relative 'paragraph'

class Article
  attr_accessor :title, :body, :paragraphs, :sections

  def initialize(params)
    self.title = params[:title]
    self.body = params[:body]
    self.paragraphs = params[:paragraphs] || []
    self.sections = params[:sections] || []
  end
  
  def to_s
    output = [title]
    if paragraphs.empty? && sections.empty?
      output << " #{body}\n"
    elsif !paragraphs.empty?
      output << " #{body}\n"
      paragraphs.each do |paragraph|
        output << paragraph.to_s
      end
    elsif !sections.empty?
      output << " #{body}\n"
      sections.each do |section|
        output << section.to_s
      end
    end
    output.join
  end
end
