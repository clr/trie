require 'c_trie/version'
require 'rake'

module CTrie
end

FileList[File.expand_path(File.join('..','c_trie','*.rb'),__FILE__)].each{|f| require f}

SHAKESPEARE = File.expand_path('../../data/shakespeare-complete.txt', __FILE__)
