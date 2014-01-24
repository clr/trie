module CTrie
  class Autocomplete
    attr :tree

    def initialize(filename, autoload=true)
      return unless autoload

      @tree = CTrie::CharNode.new ''

      # Load the corpus, one word at a time. ;-)
      encoder         = CTrie::Encoder.new @tree
      word_enumerator = CTrie::WordEnumerator.new filename

      puts ''
      puts '************************************'
      puts '     NOW ENCODING C-TRIE FROM'
      puts " #{filename}"
      puts '************************************'

      count = 1
      not_unique      = {}
      word_enumerator.each do |word|
        encoder.encode word, not_unique[word].nil?
        not_unique[word] = true

        #progress bar
        putc '.' if count % 10000  == 0
        puts ''  if count % 360000 == 0
        count += 1
      end
      puts ''
    end

    def suggest(prefix)
      finder    = CTrie::Finder.new @tree
      node      = finder.find prefix

      if node.nil?
        puts "-- no results found --"
        return
      end

      collector = CTrie::Collector.new node
      collector.collect(0, 20).map do |fragment|
        prefix.chop + fragment
      end
    end

    def dump(filename)
      File.open(filename, 'w+') do |file|
        file.write Marshal.dump @tree
      end
      puts "  Wrote C-Trie to: #{filename}"
    end

    def self.load(filename)
      autocomplete = self.new('', false)
      autocomplete.instance_variable_set(:@tree, Marshal.load(File.read(filename)))
      return autocomplete
    end
  end
end
