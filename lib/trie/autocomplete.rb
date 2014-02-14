module Trie
  class Autocomplete
    attr :tree

    # The whole shebang.  This object is the controller,
    # orchestrating the objects necessary for processing
    # a corpus and autocompleting words by frequency.
    def initialize(filename=nil)
      return unless filename

      @tree = Trie::CharNode.new ''
      print_pre_processing_banner

      # Load the corpus, one word at a time. ;-)
      encoder         = Trie::Encoder.new @tree
      word_enumerator = Trie::WordEnumerator.new filename

      word_enumerator.each_with_index do |word, count|
        encoder.encode word
        print_progress_point count
      end
      word_enumerator.close

      print_post_processing_banner
    end

    # Navigate the tree through the prefix, and 
    # suggest the autocompleted words.
    def suggest(prefix)
      finder = Trie::Finder.new @tree
      node   = finder.find prefix

      print_no_results if node.nil?

      collector = Trie::Collector.new node
      collector.collect(0, 25).map do |fragment|
        prefix.chop + fragment
      end
    end

    # Write out a processed corpus so that it can
    # be loaded later.
    def dump(filename)
      File.open(filename, 'w+') do |file|
        file.write Marshal.dump @tree
      end
      puts "  Wrote Trie to: #{filename}"
    end

    # Load a pre-processed corpus.
    def load(filename)
      @tree = Marshal.load File.read filename
      puts "  Read Trie from: #{filename}"
    end

    # Helpers for printing.
    private
    def print_pre_processing_banner(filename='')
      puts ''
      puts '************************************'
      puts '     NOW ENCODING TRIE FROM'
      puts " #{filename}"
      puts '************************************'
    end

    def print_post_processing_banner(filename='')
      puts ''
      puts '************************************'
    end

    def print_progress_point(count)
      putc '.' if count % 10000  == 0
      puts ''  if count % 360000 == 0
    end

    def print_no_results
      puts '********* NO RESULTS FOUND *********'
    end

  end
end
