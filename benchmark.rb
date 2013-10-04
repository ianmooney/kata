#!/usr/bin/ruby

require './lib/boot.rb'

word = Word.long[0]

Benchmark.bm do |x|
  x.report('::all') { Word.all }
  x.report('#sub_words') {word.sub_words}
  x.report('::with_sub_words:') { Word.with_sub_words }
end
