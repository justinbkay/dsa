defmodule DSA.StackTest do
  use ExUnit.Case, async: true
  alias DSA.Stack

  setup do
    {:ok, stack} = Stack.start_link([])
    [stack: stack]
  end

  test "The stack starts as an empty list", context do
    assert Stack.length(context[:stack]) == 0
  end

  test "We can add an item to the stack", context do
    Stack.push(context[:stack], "undies")
    assert Stack.length(context[:stack]) == 1
  end

  test "We can return an item from the stack", context do
    Stack.push(context[:stack], "undies")
    assert Stack.pop(context[:stack]) == "undies"
    assert Stack.length(context[:stack]) == 0
  end

  test "we can test if the stack is empty", context do
    assert Stack.is_empty?(context[:stack]) == true
  end

  test "we can see the next item to remove in the stack", context do
    Stack.push(context[:stack], "undies")
    Stack.push(context[:stack], "socks")
    Stack.push(context[:stack], "pants")
    assert Stack.peek(context[:stack]) == "pants"
  end

  test "the stack is lifo", context do
    Stack.push(context[:stack], "undies")
    Stack.push(context[:stack], "socks")
    Stack.push(context[:stack], "pants")
    Stack.push(context[:stack], "shoes")
    assert Stack.peek(context[:stack]) == "shoes"
    Stack.pop(context[:stack])
    assert Stack.peek(context[:stack]) == "pants"
    Stack.pop(context[:stack])
    assert Stack.peek(context[:stack]) == "socks"
  end
end