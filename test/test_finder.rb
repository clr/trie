require File.expand_path('../helper', __FILE__)

describe "Finder" do
  let(:root){ Trie::CharNode.new '' }
  let(:encoder){ Trie::Encoder.new(root) }
  let(:finder){ Trie::Finder.new(root) }

  describe "find common node" do
    before do
      encoder.encode("there")
      encoder.encode("therefore")
      encoder.encode("their")
    end

    it "finds the node matching the string" do
      node = finder.find("the")
      assert_equal node, root.children['t'].children['h'].children['e']
    end
  end

  describe "don't find wrong node" do
    before do
      encoder.encode("there")
      encoder.encode("therefore")
      encoder.encode("their")
    end

    it "doesn't find a node that doesn't exist" do
      node = finder.find("nope")
      assert_equal node, nil
    end
  end
end
