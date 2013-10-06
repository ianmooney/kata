#!/usr/bin/ruby

require './lib/boot.rb'

words = Word.concatenated_words
puts "Found #{words.count} concatenated words:"
puts ''
words.each do |word|
  puts word.print
end
