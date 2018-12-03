defmodule DSA.HighPriorityQueueTest do
  use ExUnit.Case, async: true
  alias DSA.HighPriorityQueue

  test "there are two queues" do
    {:ok, hpq} = HighPriorityQueue.start_link(%{})
    assert HighPriorityQueue.high_priority(hpq) == []
    assert HighPriorityQueue.low_priority(hpq) == []
  end

  test "we can add items to the queue" do
    {:ok, hpq} = HighPriorityQueue.start_link(%{})

    HighPriorityQueue.enqueue(hpq, "first")
    assert HighPriorityQueue.low_priority(hpq) == ["first"]
    assert HighPriorityQueue.high_priority(hpq) == []
  end

  test "we can add high priority items to the queue" do
    {:ok, hpq} = HighPriorityQueue.start_link(%{})

    HighPriorityQueue.enqueue(hpq, "first", :high_priority)
    assert HighPriorityQueue.high_priority(hpq) == ["first"]
    assert HighPriorityQueue.low_priority(hpq) == []
  end

  test "we can dequeue items properly" do
    {:ok, hpq} = HighPriorityQueue.start_link(%{})

    HighPriorityQueue.enqueue(hpq, "first", :high_priority)
    HighPriorityQueue.enqueue(hpq, "first")

    HighPriorityQueue.dequeue(hpq)
    assert HighPriorityQueue.high_priority(hpq) == []
    assert HighPriorityQueue.low_priority(hpq) == ["first"]
    HighPriorityQueue.dequeue(hpq)
    assert HighPriorityQueue.low_priority(hpq) == []
  end

  test "we can peek at the next item in the queue" do
    {:ok, hpq} = HighPriorityQueue.start_link(%{})

    HighPriorityQueue.enqueue(hpq, "first HP", :high_priority)
    HighPriorityQueue.enqueue(hpq, "second HP", :high_priority)
    HighPriorityQueue.enqueue(hpq, "first")
    HighPriorityQueue.enqueue(hpq, "second")

    assert HighPriorityQueue.peek(hpq) == "first HP"
    HighPriorityQueue.dequeue(hpq)
    assert HighPriorityQueue.peek(hpq) == "second HP"
    HighPriorityQueue.dequeue(hpq)
    assert HighPriorityQueue.peek(hpq) == "first"
    HighPriorityQueue.dequeue(hpq)
    assert HighPriorityQueue.peek(hpq) == "second"
    HighPriorityQueue.dequeue(hpq)
    assert HighPriorityQueue.peek(hpq) == ""
  end

  test "if both queues are empty, we can detect it" do
    {:ok, hpq} = HighPriorityQueue.start_link(%{})

    HighPriorityQueue.enqueue(hpq, "first HP", :high_priority)
    HighPriorityQueue.enqueue(hpq, "first")

    HighPriorityQueue.is_empty?(hpq) == false
    HighPriorityQueue.dequeue(hpq)
    HighPriorityQueue.is_empty?(hpq) == false
    HighPriorityQueue.dequeue(hpq)
    HighPriorityQueue.is_empty?(hpq) == true

  end
end