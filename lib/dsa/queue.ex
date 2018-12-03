defmodule DSA.Queue do
  use Agent

  @doc """
  Starts a new queue
  """

  def start_link(_opts) do
    Agent.start_link(fn -> [] end)
  end

  def get_all(queue) do
    Agent.get(queue, fn(state) -> state end)
  end

  def enqueue(queue, item) do
    Agent.update(queue, fn(state) -> state ++ [item] end)
  end

  def dequeue(queue) do
    Agent.update(queue, fn(state) -> [_ | tail] = state; tail end)
  end

  def peek(queue) do
    Agent.get(queue, fn(state) -> [head | _] = state; head end)
  end

  def is_empty(queue) do
    get_all(queue) == []
  end
end