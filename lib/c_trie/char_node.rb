module CTrie
  class CharNode
    attr_accessor :value, :count, :children

    def initialize(char)
      @value           = char
      @count           = 1
      @children        = {}
    end

    def add_child(char)
      # Increment this node's sort order if the letter already exists.
      if node = find_child(char)
        node.count += 1
      # Otherwise create a new node for the letter.
      else
        node = CharNode.new char
        children[char] = node
      end

      return node
    end

    def find_child(char)
      children[char]
    end

  end
end
