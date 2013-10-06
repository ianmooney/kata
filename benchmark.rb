#!/usr/bin/ruby

require './lib/boot.rb'

Benchmark.bm do |x|
  x.report('Readable:') { ReadableWordFinder.concatenated_words }
  x.report('Fast:') { FastWordFinder.concatenated_words }
end
