require File.expand_path('../helper', __FILE__)

describe "WordEnumerator" do
  let(:word_enumerator){ CTrie::WordEnumerator.new SHAKESPEARE }

  describe "extracting words" do
    it "gets one word at a time" do
      assert_equal "the", word_enumerator.get_word
      assert_equal "project", word_enumerator.get_word
      assert_equal "gutenberg", word_enumerator.get_word
    end

    after do
      word_enumerator.close
    end
  end

  describe "enumerating through the text" do
    it "yields each word" do
      i = 0
      word_enumerator.each do |word|
        case i
        when 0
          assert_equal "the", word
        when 1
          assert_equal "project", word
        when 2
          assert_equal "gutenberg", word
        else
          break 2
        end
        i += 1
      end
    end
  end
end
