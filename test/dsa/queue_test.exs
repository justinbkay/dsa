defmodule DSA.QueueTest do
  use ExUnit.Case, async: true

  test "new queue returns an empty list" do
    {:ok, queue} = DSA.Queue.start_link([])
    assert DSA.Queue.get_all(queue) == []
  end

  test "queue stores objects" do
    {:ok, queue} = DSA.Queue.start_link([])
    DSA.Queue.enqueue(queue, "first")
    assert DSA.Queue.get_all(queue) == ["first"]
  end

  test "can remove items from queue" do
    {:ok, queue} = DSA.Queue.start_link([])
    DSA.Queue.enqueue(queue, "first")
    DSA.Queue.dequeue(queue)
    assert DSA.Queue.get_all(queue) == []
  end

  test "you can see the next item to be removed" do
    {:ok, queue} = DSA.Queue.start_link([])
    DSA.Queue.enqueue(queue, "first")
    DSA.Queue.enqueue(queue, "second")
    DSA.Queue.enqueue(queue, "third")
    assert DSA.Queue.peek(queue) == "second"
  end

  test "can test if queue is empty" do
    {:ok, queue} = DSA.Queue.start_link([])
    assert DSA.Queue.is_empty(queue) == true
  end
end