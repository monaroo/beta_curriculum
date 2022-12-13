defmodule CounterTest do
  ExUnit.start(auto_run: false)

  defmodule CounterTest do
    use ExUnit.Case

    test "Counter.increment/1" do
      {:ok, pid} = Counter.start_link([])
      Counter.increment(pid)
      assert Counter.get_count(pid) == 1
    end

    test "Counter.decrement/1" do
      {:ok, pid} = Counter.start_link([])
      Counter.increment(pid)
      Counter.decrement(pid)
      assert Counter.get_count(pid) == 0
    end
  end

  ExUnit.run()

end
