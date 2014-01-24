require File.expand_path('../helper', __FILE__)

describe "Encoder" do
  let(:root){ CTrie::CharNode.new '' }
  let(:encoder){ CTrie::Encoder.new(root) }

  describe "add one word" do
    before do
      encoder.encode("colloquy")
    end

    it "converts word into node tree" do
      assert_equal 'c', root.children[0].value
      assert_equal 'o', root.children[0].
                             children[0].value
      assert_equal 'l', root.children[0].
                             children[0].
                             children[0].value
      assert_equal 'l', root.children[0].
                             children[0].
                             children[0].
                             children[0].value
      assert_equal 'o', root.children[0].
                             children[0].
                             children[0].
                             children[0].
                             children[0].value
      assert_equal 'q', root.children[0].
                             children[0].
                             children[0].
                             children[0].
                             children[0].
                             children[0].value
      assert_equal 'u', root.children[0].
                             children[0].
                             children[0].
                             children[0].
                             children[0].
                             children[0].
                             children[0].value
      assert_equal 'y', root.children[0].
                             children[0].
                             children[0].
                             children[0].
                             children[0].
                             children[0].
                             children[0].
                             children[0].value
    end
  end

  describe "add three words" do
    before do
      encoder.encode("there")
      encoder.encode("therefore")
      encoder.encode("their")
    end

    it "converts words into node tree" do
      assert_equal 't', root.children[0].value
      assert_equal 3,   root.children[0].sort_order

      assert_equal 'h', root.children[0].
                             children[0].value
      assert_equal 3,   root.children[0].
                             children[0].sort_order

      assert_equal 'e', root.children[0].
                             children[0].
                             children[0].value
      assert_equal 3,   root.children[0].
                             children[0].
                             children[0].sort_order

      assert_equal 'r', root.children[0].
                             children[0].
                             children[0].
                             children[0].value
      assert_equal 2,   root.children[0].
                             children[0].
                             children[0].
                             children[0].sort_order

      assert_equal 'e', root.children[0].
                             children[0].
                             children[0].
                             children[0].
                             children[0].value
      assert_equal 2,   root.children[0].
                             children[0].
                             children[0].
                             children[0].
                             children[0].sort_order

      assert_equal "\n", root.children[0].
                             children[0].
                             children[0].
                             children[0].
                             children[0].
                             children[0].value
      assert_equal 1,   root.children[0].
                             children[0].
                             children[0].
                             children[0].
                             children[0].
                             children[0].sort_order

      assert_equal 'f', root.children[0].
                             children[0].
                             children[0].
                             children[0].
                             children[0].
                             children[1].value
      assert_equal 1,   root.children[0].
                             children[0].
                             children[0].
                             children[0].
                             children[0].
                             children[1].sort_order

      assert_equal 'o', root.children[0].
                             children[0].
                             children[0].
                             children[0].
                             children[0].
                             children[1].
                             children[0].value
      assert_equal 1,   root.children[0].
                             children[0].
                             children[0].
                             children[0].
                             children[0].
                             children[1].
                             children[0].sort_order

      assert_equal 'r', root.children[0].
                             children[0].
                             children[0].
                             children[0].
                             children[0].
                             children[1].
                             children[0].
                             children[0].value
      assert_equal 1,   root.children[0].
                             children[0].
                             children[0].
                             children[0].
                             children[0].
                             children[1].
                             children[0].
                             children[0].sort_order

      assert_equal 'e', root.children[0].
                             children[0].
                             children[0].
                             children[0].
                             children[0].
                             children[1].
                             children[0].
                             children[0].
                             children[0].value
      assert_equal 1,   root.children[0].
                             children[0].
                             children[0].
                             children[0].
                             children[0].
                             children[1].
                             children[0].
                             children[0].
                             children[0].sort_order

      assert_equal "\n", root.children[0].
                             children[0].
                             children[0].
                             children[0].
                             children[0].
                             children[1].
                             children[0].
                             children[0].
                             children[0].
                             children[0].value
      assert_equal 1,   root.children[0].
                             children[0].
                             children[0].
                             children[0].
                             children[0].
                             children[1].
                             children[0].
                             children[0].
                             children[0].
                             children[0].sort_order

      assert_equal 'i', root.children[0].
                             children[0].
                             children[0].
                             children[1].value
      assert_equal 1,   root.children[0].
                             children[0].
                             children[0].
                             children[1].sort_order

      assert_equal 'r', root.children[0].
                             children[0].
                             children[0].
                             children[1].
                             children[0].value
      assert_equal 1,   root.children[0].
                             children[0].
                             children[0].
                             children[1].
                             children[0].sort_order

      assert_equal "\n", root.children[0].
                             children[0].
                             children[0].
                             children[1].
                             children[0].
                             children[0].value
      assert_equal 1,   root.children[0].
                             children[0].
                             children[0].
                             children[1].
                             children[0].
                             children[0].sort_order
    end
  end

  describe "add three words, two of which are unique" do
    before do
      encoder.encode("there", true)
      encoder.encode("there")
      encoder.encode("their", true)
    end

    it "converts words into node tree" do
      assert_equal 't', root.children[0].value
      assert_equal 3,   root.children[0].sort_order
      assert_equal 2,   root.children[0].unique_children

      assert_equal 'h', root.children[0].
                             children[0].value
      assert_equal 3,   root.children[0].
                             children[0].sort_order
      assert_equal 2,   root.children[0].
                             children[0].unique_children

      assert_equal 'e', root.children[0].
                             children[0].
                             children[0].value
      assert_equal 3,   root.children[0].
                             children[0].
                             children[0].sort_order
      assert_equal 2,   root.children[0].
                             children[0].
                             children[0].unique_children

      assert_equal 'r', root.children[0].
                             children[0].
                             children[0].
                             children[0].value
      assert_equal 2,   root.children[0].
                             children[0].
                             children[0].
                             children[0].sort_order
      assert_equal 1,   root.children[0].
                             children[0].
                             children[0].
                             children[0].unique_children

      assert_equal 'e', root.children[0].
                             children[0].
                             children[0].
                             children[0].
                             children[0].value
      assert_equal 2,   root.children[0].
                             children[0].
                             children[0].
                             children[0].
                             children[0].sort_order
      assert_equal 1,   root.children[0].
                             children[0].
                             children[0].
                             children[0].
                             children[0].unique_children

      assert_equal "\n", root.children[0].
                             children[0].
                             children[0].
                             children[0].
                             children[0].
                             children[0].value
      assert_equal 2,   root.children[0].
                             children[0].
                             children[0].
                             children[0].
                             children[0].
                             children[0].sort_order
      assert_equal 1,   root.children[0].
                             children[0].
                             children[0].
                             children[0].
                             children[0].
                             children[0].unique_children

      assert_equal 'i', root.children[0].
                             children[0].
                             children[0].
                             children[1].value
      assert_equal 1,   root.children[0].
                             children[0].
                             children[0].
                             children[1].sort_order
      assert_equal 1,   root.children[0].
                             children[0].
                             children[0].
                             children[1].unique_children

      assert_equal 'r', root.children[0].
                             children[0].
                             children[0].
                             children[1].
                             children[0].value
      assert_equal 1,   root.children[0].
                             children[0].
                             children[0].
                             children[1].
                             children[0].sort_order
      assert_equal 1,   root.children[0].
                             children[0].
                             children[0].
                             children[1].
                             children[0].unique_children

      assert_equal "\n", root.children[0].
                             children[0].
                             children[0].
                             children[1].
                             children[0].
                             children[0].value
      assert_equal 1,   root.children[0].
                             children[0].
                             children[0].
                             children[1].
                             children[0].
                             children[0].sort_order
      assert_equal 1,   root.children[0].
                             children[0].
                             children[0].
                             children[1].
                             children[0].
                             children[0].unique_children
    end
  end
end
