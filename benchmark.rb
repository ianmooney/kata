#!/usr/bin/ruby

require './lib/boot.rb'

word = Word.long_words[0]

Benchmark.bm do |x|
  x.report('::all') { Word.all }
  x.report('#sub_words') {word.sub_words}
  x.report('::words_with_sub_words:') { Word.words_with_sub_words }
end
