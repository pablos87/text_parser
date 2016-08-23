#!/usr/bin/ruby
require_relative 'article'
require_relative 'section'
require_relative 'subparagraph'

file_path = ARGV[0]                                                    
                                                                       
if file_path.nil?                                                      
  puts 'ArgumentError: CSV file path is required'                      
  exit                                                                 
end                                                                    
      
articles = []

File.foreach(file_path) do |line|                                      
  articles_data = line.scan(/(Art\. \d+\[?\d?[a-z]?\]?\.) (.*)/)
  if articles_data.empty?
    sections_data = line.scan(/(\d+\.) (.*)/)
    unless sections_data.empty?
      article = articles.last
      section_data = sections_data.first
      article.sections << Section.new(title: section_data.first,
				      body: section_data.last)
    end
    subparagraphs_data = line.scan(/(\d+\)) (.*)/)
    unless subparagraphs_data.empty?
      section = articles.last.sections.last
      subparagraph_data = subparagraphs_data.first
      section.subparagraphs << Subparagraph.new(title: subparagraph_data.first,
					        body: subparagraph_data.last)
    end
  else
    article_data = articles_data.first
    sections_data = article_data.last.scan(/\A(\d+\.) (.*)\Z/)
    unless sections_data.empty?
      section_data = sections_data.first
      articles << Article.new(title: article_data.first,
			      sections: [Section.new(title: section_data.first,
					             body: section_data.last)]
			     )
    else
      articles << Article.new(title: article_data.first,
			      body: article_data.last)
    end
  end
end

puts articles
