module CTrie
  class WordEnumerator
    attr :file

    def initialize(filename)
      @file = File.open filename, 'r'
      @line = []
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
  end
end
