require File.expand_path('../helper', __FILE__)

describe "Encoder" do
  let(:root){ CTrie::CharNode.new '' }
  let(:encoder){ CTrie::Encoder.new(root) }

  describe "add one word" do
    before do
      encoder.encode("colloquy")
    end

    it "converts word into node tree" do
      assert_equal 'c', root.children['c'].value
      assert_equal 'o', root.children['c'].
                             children['o'].value
      assert_equal 'l', root.children['c'].
                             children['o'].
                             children['l'].value
      # ...etc...
      assert_equal 'y', root.children['c'].
                             children['o'].
                             children['l'].
                             children['l'].
                             children['o'].
                             children['q'].
                             children['u'].
                             children['y'].value
    end
  end

  describe "add three words" do
    before do
      encoder.encode("there")
      encoder.encode("therefore")
      encoder.encode("their")
    end

    it "converts words into node tree" do
      node = root.children['t']
      assert_equal 't', node.value
      assert_equal 3,   node.count

      node = node.children['h']
      assert_equal 'h', node.value
      assert_equal 3,   node.count

      node_fork_1 = node.children['e']
      assert_equal 'e', node_fork_1.value
      assert_equal 3,   node_fork_1.count

      node = node_fork_1.children['r']
      assert_equal 'r', node.value
      assert_equal 2,   node.count

      node_fork_2 = node.children['e']
      assert_equal 'e', node_fork_2.value
      assert_equal 2,   node_fork_2.count

      node = node_fork_2.children["\n"]
      assert_equal "\n", node.value
      assert_equal 1,    node.count

      node = node_fork_2.children['f']
      assert_equal 'f', node.value
      assert_equal 1,   node.count

      node = node.children['o']
      assert_equal 'o', node.value
      assert_equal 1,   node.count

      node = node.children['r']
      assert_equal 'r', node.value
      assert_equal 1,   node.count

      node = node.children['e']
      assert_equal 'e', node.value
      assert_equal 1,   node.count

      node = node.children["\n"]
      assert_equal "\n", node.value
      assert_equal 1,   node.count

      node = node_fork_1.children['i']
      assert_equal 'i', node.value
      assert_equal 1,   node.count

      node = node.children['r']
      assert_equal 'r', node.value
      assert_equal 1,   node.count

      node = node.children["\n"]
      assert_equal "\n", node.value
      assert_equal 1,    node.count
    end

  end

  describe "add three words, two of which are unique" do
    before do
      encoder.encode("there")
      encoder.encode("there")
      encoder.encode("their")
    end

    it "converts words into node tree" do
      node = root.children['t']
      assert_equal 't', node.value
      assert_equal 3,   node.count

      node = node.children['h']
      assert_equal 'h', node.value
      assert_equal 3,   node.count

      node_fork = node.children['e']
      assert_equal 'e', node_fork.value
      assert_equal 3,   node_fork.count

      node = node_fork.children['r']
      assert_equal 'r', node.value
      assert_equal 2,   node.count

      node = node.children['e']
      assert_equal 'e', node.value
      assert_equal 2,   node.count

      node = node.children["\n"]
      assert_equal "\n", node.value
      assert_equal 2,    node.count

      node = node_fork.children['i']
      assert_equal 'i', node.value
      assert_equal 1,   node.count

      node = node.children['r']
      assert_equal 'r', node.value
      assert_equal 1,   node.count

      node = node.children["\n"]
      assert_equal "\n", node.value
      assert_equal 1,    node.count
    end

  end
end
