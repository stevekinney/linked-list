require "minitest/autorun"
require "minitest/spec"
require "minitest/pride"

require "./lib/node"

describe Node do

  it "responds to 'data'" do
    node = Node.new("some data")

    assert_respond_to(node, :data)
  end

  it "responds to 'next'" do
    node = Node.new("some data")

    assert_respond_to(node, :next)
  end

  it "had the data passed in" do
    node = Node.new("some data")

    assert_equal(node.data, "some data")
  end

end