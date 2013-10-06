#!/usr/bin/ruby

require './lib/boot.rb'

FastFinder.suppress_output = true

Benchmark.bm do |x|
  x.report('Readable:') { Readable::Word.concatenated_words }
  x.report('Fast:') { FastFinder.concatenated_words }
  x.report('Extendible:') { Extendible::Word.concatenated_words }
end
