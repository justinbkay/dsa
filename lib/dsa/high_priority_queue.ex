require IEx
defmodule DSA.HighPriorityQueue do
  use Agent

  def start_link(_opts) do
    Agent.start_link(fn ->
      %{:reg => [], :hp => []}
    end)
  end

  def high_priority(hpq) do
    Agent.get(hpq, fn(state) -> Map.get(state, :hp) end)
  end

  def low_priority(hpq) do
    Agent.get(hpq, fn(state) -> Map.get(state, :reg) end)
  end

  def enqueue(hpq, item) do
    Agent.update(hpq, fn(state) ->
      reg = Map.get(state, :reg)
      newreg = reg ++ [item]
      %{state | reg: newreg}
    end)
  end

  def enqueue(hpq, item, _) do
    Agent.update(hpq, fn(state) ->
      hp = Map.get(state, :hp)
      newhp = hp ++ [item]
      %{state | hp: newhp}
    end)
  end

  def dequeue(hpq) do
    # if hp is empty, then we dequeue from reg otherwise we dequeue hp
    if high_priority(hpq) == [] do
      Agent.update(hpq, fn(state) ->
        reg = Map.get(state, :reg)
        [_ | tail] = reg
        %{state | reg: tail}
      end)
    else
      Agent.update(hpq, fn(state) ->
        hp = Map.get(state, :hp)
        [_ | tail] = hp
        %{state | hp: tail}
      end)
    end
  end

  def peek(hpq) do
    if high_priority(hpq) == [] do
      Agent.get(hpq, fn(state) ->
        reg = Map.get(state, :reg)
        case reg do
          [] ->
            ""
          _ ->
            [head | _] = reg
            head
        end
      end)
    else
      Agent.get(hpq, fn(state) ->
        hp = Map.get(state, :hp)
        [head | _] = hp
        head
      end)
    end
  end

  def is_empty?(hpq) do
    if high_priority(hpq) == [] && low_priority(hpq) == [] do
      true
    else
      false
    end
  end
end