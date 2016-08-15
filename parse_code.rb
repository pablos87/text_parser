#!/usr/bin/ruby
require_relative 'article'
require_relative 'paragraph'

file_path = ARGV[0]                                                    
                                                                       
if file_path.nil?                                                      
  puts 'ArgumentError: CSV file path is required'                      
  exit                                                                 
end                                                                    
      
articles = []
formatted_text = ''          

File.foreach(file_path) do |line|                                      
  articles_data = line.scan(/(Art\. \d+\.) (.*)/)
  if articles_data.empty?
    paragraphs_data = line.scan(/(§ \d+\.) (.*)/)
    unless paragraphs_data.empty?
      article = articles.last
      paragraph_data = paragraphs_data.first
      article.paragraphs << Paragraph.new(title: paragraph_data.first,
					  body: paragraph_data.last)
    end
  else
    article_data = articles_data.first
    paragraphs_data = article_data.last.scan(/(§ \d+\.) (.*)/)
    unless paragraphs_data.empty?
      paragraph_data = paragraphs_data.first
      articles << Article.new(title: article_data.first,
			      paragraphs: [Paragraph.new(title: paragraph_data.first,
							body: paragraph_data.last)]
			     )
    else
      articles << Article.new(title: article_data.first,
			      body: article_data.last)
    end
  end
  replace_string =
    if line.chars.first == '§' 
      "\t§"
    else
      "\n\t§"
    end
  formatted_text << line.sub("§", replace_string)                      
end

puts articles
puts formatted_text

if formatted_text <=> articles.to_s
  puts "\nPorównywane teksty są takie same"
else
  puts "\nPorównywane teksty różnią się"
end

