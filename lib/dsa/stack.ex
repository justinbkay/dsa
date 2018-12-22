defmodule DSA.Stack do
  use Agent

  def start_link(_opts) do
    Agent.start_link(fn ->
      []
    end)
  end

  def length(stack) do
    Agent.get(stack, fn(state) -> Kernel.length(state) end)
  end

  def push(stack, item) do
    Agent.update(stack, fn(state) -> [item | state]  end)
  end

  def pop(stack) do
    head = Agent.get(stack, fn(state) -> [head| _] = state; head end)
    Agent.update(stack, fn(state) ->
      [_|tail] = state
      tail
    end)
    head
  end

  def is_empty?(stack) do
    DSA.Stack.length(stack) == 0
  end

  def peek(stack) do
    Agent.get(stack, fn(state) -> [head|_] = state; head end)
  end
end