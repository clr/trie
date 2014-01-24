module CTrie
  class Encoder
    attr :tree

    def initialize(tree)
      @tree = tree
    end

    def encode(word, unique=false)
      node = @tree
      (word + "\n").each_char do |char|
        node = node.add_child char, unique
      end
    end
  end
end
