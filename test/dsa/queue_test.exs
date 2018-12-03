defmodule DSA.QueueTest do
  use ExUnit.Case, async: true
  alias DSA.Queue

  test "new queue returns an empty list" do
    {:ok, queue} = Queue.start_link([])
    assert Queue.get_all(queue) == []
  end

  test "queue stores objects" do
    {:ok, queue} = Queue.start_link([])
    Queue.enqueue(queue, "first")
    assert Queue.get_all(queue) == ["first"]
  end

  test "can remove items from queue" do
    {:ok, queue} = Queue.start_link([])
    Queue.enqueue(queue, "first")
    Queue.dequeue(queue)
    assert Queue.get_all(queue) == []
  end

  test "you can see the next item to be removed" do
    {:ok, queue} = Queue.start_link([])
    Queue.enqueue(queue, "first")
    Queue.enqueue(queue, "second")
    Queue.enqueue(queue, "third")
    assert Queue.peek(queue) == "first"
  end

  test "can test if queue is empty" do
    {:ok, queue} = Queue.start_link([])
    assert Queue.is_empty(queue) == true
  end
end