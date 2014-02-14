require File.expand_path('../helper', __FILE__)

describe "CharNode" do
  let(:root){ Trie::CharNode.new '' }

  describe "add children" do
    before do
      root.add_child 'a'
      root.add_child 'b'
      root.add_child 'b'
    end

    it "has two children" do
      assert_equal 2, root.children.length
    end

    it "counted children types" do
      assert_equal 1, root.children['a'].count
      assert_equal 2, root.children['b'].count
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
      assert_equal 'z', root.children['z'].value
      assert_equal 'z', root.children['z'].children['z'].value
      assert_equal 'z', root.children['z'].children['z'].children['z'].value
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
      assert_equal root.children['c'], root.find_child('c')
    end
  end

end
