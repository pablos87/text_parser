#!/usr/bin/ruby

file_path = ARGV[0]

if file_path.nil?
  puts 'ArgumentError: CSV file path is required'
  exit
end

File.foreach(file_path) do |line|
  replace_string = 
    if line.chars.first == '§'
      "\t§"
    else
      "\n\t§"
    end
  puts line.sub("§", replace_string)
end

