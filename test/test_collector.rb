require File.expand_path('../helper', __FILE__)

describe "Collector" do
  let(:root){ Trie::CharNode.new '' }
  let(:encoder){ Trie::Encoder.new(root) }
  let(:finder){ Trie::Finder.new(root) }
  let(:collector){ Trie::Collector.new(root) }

  # This should sort itself out to roughly the following tree:
  # theory
  #    re
  #      fore           <= index 2
  #      tohither
  #      itis
  #     ighteous
  #    mselves
  #        f
  #    y
  #    nsome
  #                     <= the word 'the', index 10
  #  onight
  before do
    encoder.encode "tonight"
    encoder.encode "there"
    encoder.encode "therefore"
    encoder.encode "theory"
    encoder.encode "theretohither"
    encoder.encode "they"
    encoder.encode "thensome"
    encoder.encode "thereitis"
    encoder.encode "themselves"
    encoder.encode "themself"
    encoder.encode "therighteous"
    encoder.encode "the"
    # The following are no longer unique.
    encoder.encode "theory"
    encoder.encode "theory"
    encoder.encode "theory"
    encoder.encode "theory"
    encoder.encode "theory"
  end

  describe "traverse the tree" do

    it "recursively reconstruct the branch as a nested array of hashes where key is char and value is count" do
      result = [
        [[[[[[[{"tonight " => 1}]]]]]],
           [[[[{"there " => 1},
           [[[[{"therefore " => 1}]]]],
       [[[[[[[[{"theretohither " => 1}]]]]]]]],
           [[[[{"thereitis " => 1}]]]]],
       [[[[[[[[{"therighteous " => 1}]]]]]]]]],
            [[[{"theory " => 6}]]],
              [{"they " => 1}],
          [[[[[{"thensome " => 1}]]]]],
        [[[[[[[{"themselves " => 1}]]],
              [{"themself " => 1}]]]]],
               {"the " => 1}]]]
      ]
      assert_equal result, collector.traverse_fragment
    end

  end

  describe "collecting a bunch of fragments at once" do

    it "finds 4 fragments in the middle" do
      assert_equal ["thereitis 1", "therighteous 1", "there 1", "they 1"], collector.collect(4, 4)
    end

    it "removes trailing nils when solution is smaller than requested size" do
      assert_equal ["themselves 1", "themself 1", "the 1"], collector.collect(9, 7)
    end

  end
end
