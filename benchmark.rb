#!/usr/bin/ruby

require './lib/boot.rb'

word = Word.new(:name => 'bitter')

Benchmark.bm do |x|
  x.report('::all') { Word.all }
  x.report('::concatenated_words:') { Word.concatenated_words }
end
