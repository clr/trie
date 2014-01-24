require File.expand_path('../helper', __FILE__)

describe "Finder" do
  let(:root){ CTrie::CharNode.new '' }
  let(:encoder){ CTrie::Encoder.new(root) }
  let(:finder){ CTrie::Finder.new(root) }

  describe "find common node" do
    before do
      encoder.encode("there")
      encoder.encode("therefore")
      encoder.encode("their")
    end

    it "finds the node matching the string" do
      node = finder.find("the")
      assert_equal node, root.children[0].children[0].children[0]
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
