#!/usr/bin/ruby

file_path = ARGV[0]

if file_path.nil?
  puts 'ArgumentError: CSV file path is required'
  exit
end

File.foreach(file_path) do |line|
  puts line.sub("§", "\n\t§")
end

