#!/usr/bin/ruby

require './lib/boot.rb'

# FastFinder.concatenated_words
# Readable::Word.print_words
Extendible::Word.print_words(:length => ARGV[0], :file_name => ARGV[1])