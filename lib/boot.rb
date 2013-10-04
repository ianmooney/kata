require 'benchmark'

Dir['./lib/models/*'].each {|file| require file }