require File.expand_path('../helper', __FILE__)

describe "Autocomplete" do

  describe "finishing my word" do
    let(:autocomplete){ Trie::Autocomplete.new SHAKESPEARE }
    let(:result){
      ["the 27843", "thee 3181", "they 2534", "then 2223", "there 2212", "their 2079",
       "them 1980", "these 1327", "therefore 627", "themselves 159", "thersites 125",
       "thence 90", "theseus 69", "therein 56", "thereof 39", "theirs 31", "theme 28",
       "thereby 26", "thereto 17", "theft 15", "therewithal 9", "thereupon 8", "thereon 7",
       "theatre 6", "thetis 4"]
    }

    it "finds some 'the's" do
      assert_equal result, autocomplete.suggest('the')
    end

  end

  describe "dump and load Trie" do
    let(:autocomplete){ Trie::Autocomplete.new "#{SHAKESPEARE}.short" }
    let(:result){
      ["the 75", "thee 11", "then 6", "their 4", "they 2", "thereby 1", "there 1"]
    }

    it "dumps, loads, suggests" do
      test_filename = "#{SHAKESPEARE}.test_output"
      autocomplete.dump test_filename
      autocomplete = Trie::Autocomplete.new
      autocomplete.load test_filename
      assert_equal result, autocomplete.suggest('the')

      # Cleanup.
      File.unlink test_filename
    end

  end
end
