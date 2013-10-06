#!/usr/bin/ruby

require './lib/boot.rb'

FastFinder.suppress_output = true

Benchmark.bm do |x|
  x.report('Readable:') { Word.concatenated_words }
  x.report('Fast:') { FastFinder.concatenated_words }
end
