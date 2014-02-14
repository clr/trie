module Trie
  class Encoder
    attr :tree

    def initialize(tree)
      @tree = tree
    end

    def encode(word)
      node = @tree
      word.each_char do |char|
        node = node.add_child char
      end
      node.add_child "\n"
    end
  end
end
