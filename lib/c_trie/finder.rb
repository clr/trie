module CTrie
  class Finder
    attr :tree

    def initialize(tree)
      @tree = tree
    end

    def find(word)
      node = @tree
      word.each_char do |char|
        node = node.find_child char
        break if node.nil?
      end
      node
    end
  end
end
