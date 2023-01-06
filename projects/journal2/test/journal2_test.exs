defmodule Journal2Test do
  use ExUnit.Case
  doctest Journal2

  test "greets the world" do
    assert Journal2.hello() == :world
  end
end
