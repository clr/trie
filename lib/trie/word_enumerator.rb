module Trie
  class WordEnumerator
    attr :file

    def initialize(filename)
      @file  = File.open filename, 'r'
      @line  = []
      @count = 0
    end

    def close
      @file.close
    end

    def get_word
      if @line.length == 0
        # Making an assumption that we only want words.
        @line = @file.gets.gsub(/[^a-zA-Z ]/, ' ').split
      end
      (@line.shift || '').downcase
    end

    def each(&block)
      while !@file.eof?
        yield get_word
      end
      @file.rewind
    end

    def each_with_index(&block)
      while !@file.eof?
        @count += 1
        yield [get_word, @count]
      end
      @file.rewind
      @count = 0
    end

  end
end
