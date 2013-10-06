require 'benchmark'

Dir['./lib/models/*.rb', './lib/models/**/*.rb'].each {|file| require file }