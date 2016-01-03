require "minitest/autorun"
require "minitest/spec"
require "minitest/pride"

require "./lib/linked_list"
require "./lib/node"

describe LinkedList do

  def setup
    @list = LinkedList.new("head")
  end

  it "has a head node" do
    assert_respond_to(@list, :head)
    assert_instance_of(Node, @list.head)
  end

  it "has a head node that holds the data passed in" do
    assert_equal(@list.head.data, "head")
  end

  it "responds to #tail" do
    assert_respond_to(@list, :tail, "LinkedList does not respond to #tail")
  end

  it "returns a Node when responding to #tail" do
    assert_instance_of(Node, @list.tail, "#tail does not return a Node" )
  end

  it "can fetch the last node on a list" do
    @list.head.next = Node.new("intermediary")
    @list.head.next.next = Node.new("final")

    assert_equal("final", @list.tail.data)
  end

  it "can append a node to the end of the list" do
    @list.append("appended")

    assert_equal("appended", @list.head.next.data)
  end

  it "can prepend a node onto the beginning of the list" do
    @list.prepend("new head")

    assert_equal("new head", @list.head.data)
  end

  it "can tell if it #includes? a node with a given data" do
    @list.append("find me").append("false positive")

    assert(@list.includes?("find me"), "LinkedList cannot find a node with data provided")
  end

  it "#includes? returns false if it doesn't include a node with given data" do
    refute(@list.includes?("not in here"), "LinkedList#includes? falsely returns true")
  end

  it "can count the number of nodes" do
    @list.append("second").append("third")

    assert_equal(3, @list.count)
  end

  it "can find a node by value" do
    @list.append("find me").append("false positive")

    assert_equal("find me", @list.find_by_value("find me").data)
  end

  it "can find a node by index" do
    @list.append("one").append("two").append("three")

    assert_equal("two", @list.find_by_index(2).data)
  end

  it "can insert a node a given index" do
    @list.append("one").append("will be three").append("will be four")

    @list.insert("two", 2)

    assert_equal("two", @list.find_by_index(2).data)
  end

  it "can pop a node off the end of the list" do
    @list.append("penultimate").append("ultimate")
    original_list_count = @list.count

    last_node = @list.pop

    assert_equal("ultimate", last_node.data)
    assert_equal("penultimate", @list.tail.data)
    assert_equal(original_list_count - 1, @list.count)
  end

  it "can remove a node at a given index" do
    @list.append("one").append("two")

    removed_node = @list.remove_by_index(1)

    assert_equal("one", removed_node.data)
    assert_equal("two", @list.head.next.data)
  end

  it "Can remove a node with a given value" do
    @list.append("one").append("two")

    removed_node = @list.remove_by_value("one")

    assert_equal("one", removed_node.data)
    assert_equal("two", @list.head.next.data)
  end

end