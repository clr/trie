module CTrie
  class CharNode
    attr_accessor :value, :unique_children, :sort_order, :children

    def initialize(char)
      @value           = char
      @unique_children = 0
      @sort_order      = 1
      @children        = []
    end

    def add_child(char, unique=false)

      # Increment this node's sort order if the letter already exists.
      if node = find_child(char)
        node.unique_children += 1 if unique
        node.sort_order += 1
      # Otherwise create a new node for the letter.
      else
        node = CharNode.new char
        node.unique_children += 1 if unique
        children << node
      end

      sort_children!
      return node
    end

    def find_child(char)
      children.find{|child| child.value == char}
    end

    private
    def sort_children!
      children.sort!{|a,b| b.sort_order <=> a.sort_order}
    end
  end
end
