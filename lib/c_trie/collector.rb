module CTrie
  class Collector
    attr :tree

    def initialize(tree)
      @tree = tree
    end

    def traverse_fragment(index)
      # Terminating condition for recursion.
      return '' if tree.value == "\n"

      # If the index doesn't land in the first child, then we have to
      # fastforward to the child node that has this index.
      i = 0
      while(index >= tree.children[i].unique_children)
        index -= tree.children[i].unique_children
        i += 1

        # Catch if the index is out-of-range, and return nil in that
        # case because we are out of branches to traverse.
        if tree.children[i].nil?
          return nil
        end
      end

      # Otherwise, continue traversing the tree and append characters as
      # we go.
      collector = self.class.new tree.children[i]
      return tree.value + collector.traverse_fragment(index)
    end

    def collect(offset, length)
      result ||= []
      while(length > 0) do
        result << traverse_fragment(offset)
        offset += 1
        length -= 1
      end
      result.compact
    end
  end
end
