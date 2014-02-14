require 'trie/version'
require 'rake'

module Trie
end

FileList[File.expand_path(File.join('..','trie','*.rb'),__FILE__)].each{|f| require f}

SHAKESPEARE = File.expand_path('../../data/shakespeare-complete.txt', __FILE__)
