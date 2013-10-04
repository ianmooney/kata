#!/usr/bin/ruby

require './lib/boot.rb'

Word.all.each do |word|
  puts word if word.made_of_sub_words?
end
