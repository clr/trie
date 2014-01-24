require File.expand_path('../helper', __FILE__)

describe "CharNode" do
  let(:root){ CTrie::CharNode.new '' }

  describe "add children" do
    before do
      root.add_child 'a'
      root.add_child 'b'
      root.add_child 'b'
    end

    it "has two children" do
      assert_equal 2, root.children.length
    end

    it "sorted the children by count" do
      assert_equal 'b', root.children[0].value
      assert_equal 'a', root.children[1].value
    end

    it "counted children types" do
      assert_equal 2, root.children[0].sort_order
      assert_equal 1, root.children[1].sort_order
    end
  end

  describe "add a tree branch" do
    before do
      node = root
      3.times do
        node = node.add_child 'z'
      end
    end

    it "has a branch of 'z's" do
      assert_equal 'z', root.children[0].value
      assert_equal 'z', root.children[0].children[0].value
      assert_equal 'z', root.children[0].children[0].children[0].value
    end
  end

  describe "find a child" do
    before do
      root.add_child 'a'
      root.add_child 'b'
      root.add_child 'c'
      root.add_child 'd'
    end

    it "can be found by value" do
      assert_equal root.children[2], root.find_child('c')
    end
  end

  describe "add the same new child and flag it as unique" do
    before do
      root.add_child 'a', true
      root.add_child 'a', true
      root.add_child 'a', true
    end

    it "thinks it has 3 unique children because we passed in the 'true' flag" do
      assert_equal 3, root.find_child('a').unique_children
    end

  end
end
