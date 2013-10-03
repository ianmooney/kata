#!/usr/bin/ruby

require './lib/boot.rb'

Word.word_array.each do |word|
  puts word if word.made_of_sub_words?
end
