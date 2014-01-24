$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'minitest/spec'
require 'minitest/autorun'

require File.join('lib','c_trie')
