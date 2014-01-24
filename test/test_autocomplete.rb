require File.expand_path('../helper', __FILE__)

describe "Autocomplete" do

  describe "finishing my word" do
    let(:autocomplete){ CTrie::Autocomplete.new SHAKESPEARE }
    let(:result){ %w(the thee there therefore therein thereof thereon
                     thereby thereto thereupon thereunto therewithal therewith
                     thereabouts thereabout thereat thereafter thersites they then) }

    it "finds some 'the's" do
      assert_equal result, autocomplete.suggest('the')
    end

  end

  describe "dump and load C-Trie" do
    let(:autocomplete){ CTrie::Autocomplete.new "#{SHAKESPEARE}.short" }
    let(:result){ %w(the thee then their thereby there they) }

    it "dumps, loads, suggests" do
      autocomplete.dump "#{SHAKESPEARE}.test_output"
      autocomplete = CTrie::Autocomplete.load "#{SHAKESPEARE}.test_output"
      assert_equal result, autocomplete.suggest('the')
    end

  end
end
