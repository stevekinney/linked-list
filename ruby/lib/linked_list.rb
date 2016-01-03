require "./lib/node"

class LinkedList

  attr_reader :head

  def initialize(initial_data)
    @head = Node.new(initial_data)
  end

  def tail(current_node = @head)
    return current_node if current_node.next.nil?
    tail(current_node.next)
  end

  def append(data)
    tap { tail.next = Node.new(data) }
  end

  def prepend(data)
    tap do
      new_head = Node.new(data)
      new_head.next = @head
      @head = new_head
    end
  end

  def includes?(data, current_node = @head)
    return true if current_node.data == data
    current_node.next.nil? ? false : includes?(data, current_node.next)
  end

  def count(current_node = @head, current_count = 1)
    next_node = current_node.next
    next_node.nil? ? current_count : count(next_node, current_count + 1)
  end

  def find_by_value(data, current_node = @head)
    return current_node if current_node.data == data
    current_node.next.nil? ? false : find_by_value(data, current_node.next)
  end

  def find_by_index(index, current_index = 0, current_node = @head)
    return current_node if index == current_index
    find_by_index(index, current_index + 1, current_node.next)
  end

  def index_of_value(value, current_index = 0, current_node = @head)
    return current_index if current_node.data == value
    index_of_value(value, current_index + 1, current_node.next)
  end

  def insert(data, index)
    tap do
      before = find_by_index(index - 1)
      after = find_by_index(index)
      before.next = Node.new(data)
      before.next.next = after
    end
  end

  def pop
    tail.tap { find_by_index(count - 2).next = nil }
  end

  def remove_by_index(index)
    find_by_index(index).tap do |node|
      previous_node = find_by_index(index - 1)
      previous_node.next = node.next
    end
  end

  def remove_by_value(value)
    find_by_value(value).tap do |node_to_be_removed|
      previous_node = find_by_index(index_of_value(value) - 1)
      previous_node.next = node_to_be_removed.next
    end
  end

end