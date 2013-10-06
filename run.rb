#!/usr/bin/ruby

require './lib/boot.rb'

if ARGV[0] == 'readable'
  puts "Finding words..."
  Readable::Word.print_words
elsif ARGV[0] == 'fast'
  FastFinder.concatenated_words
else
  puts "Finding words..."
  Extendible::Word.print_words(:length => ARGV[0], :file_name => ARGV[1])
end