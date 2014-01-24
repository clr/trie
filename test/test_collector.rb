require File.expand_path('../helper', __FILE__)

describe "Collector" do
  let(:root){ CTrie::CharNode.new '' }
  let(:encoder){ CTrie::Encoder.new(root) }
  let(:finder){ CTrie::Finder.new(root) }
  let(:collector){ CTrie::Collector.new(root) }

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
    encoder.encode "tonight", true
    encoder.encode "there", true
    encoder.encode "therefore", true
    encoder.encode "theory", true
    encoder.encode "theretohither", true
    encoder.encode "they", true
    encoder.encode "thensome", true
    encoder.encode "thereitis", true
    encoder.encode "themselves", true
    encoder.encode "themself", true
    encoder.encode "therighteous", true
    encoder.encode "the", true
    # The following are no longer unique.
    encoder.encode "theory", false
    encoder.encode "theory", false
    encoder.encode "theory", false
    encoder.encode "theory", false
    encoder.encode "theory", false
  end

  describe "traverse a word fragment at a specific index" do

    it "finds a short word" do
      assert_equal 'there', collector.traverse_fragment(1)
      assert_equal 'the', collector.traverse_fragment(10)
    end

    # Note that this is in a different order than they were inserted.
    # This is sorted by most popular characters [CharNodes with highest
    # count.]
    it "finds each word in the correct place" do
      %w(theory there therefore theretohither thereitis therighteous themselves
         themself they thensome the tonight).each_with_index do |word, index|
        assert_equal word, collector.traverse_fragment(index)
      end
    end

  end

  describe "collecting a bunch of fragments at once" do

    it "finds 4 fragments in the middle" do
      assert_equal %w(thereitis therighteous themselves themself), collector.collect(4, 4)
    end

    it "removes trailing nils when solution is smaller than requested size" do
      assert_equal %w(thensome the tonight), collector.collect(9, 7)
    end

  end
end
