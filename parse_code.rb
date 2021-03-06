#!/usr/bin/ruby
require_relative 'article'
require_relative 'paragraph'
require_relative 'text_equality_test'
require 'test/unit/assertions'
include Test::Unit::Assertions

file_path = ARGV.shift || raise("Usage: #{$PROGRAM_NAME} raw-legal.txt")                                                                      
      
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
sd = articles.to_s
assert_equal formatted_text, "#{articles.join("\n")}\n", "Compared texts are not equal"

