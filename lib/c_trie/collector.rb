module CTrie
  class Collector
    attr :tree

    def initialize(tree)
      @tree = tree
    end

    def traverse_fragment(prefix='')
      # Terminating condition for recursion.
      return {"#{prefix} " => tree.count} if tree.value == "\n"

      # Otherwise, continue traversing the tree and append characters as
      # we go.
      return tree.children.collect do |child|
        collector = self.class.new child[1]
        collector.traverse_fragment("#{prefix}#{tree.value}")
      end
    end

    def collect(offset, length)
      # A little array nip and tuck, Law of Demeter be darned. ;-)
      traverse_fragment.
        # We get back a nested array of hash values; we only want the
        # hash values.
        flatten.
        map{|hash| hash.to_a.flatten }.
        # We want the results sorted by the count.
        sort{|a, b| b[1] <=> a[1]}.
        # Join the fragment and the count int a string.
        map(&:join)[offset, length]
    end
  end
end
