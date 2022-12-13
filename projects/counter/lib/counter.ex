defmodule Counter do
  use GenServer

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, 0)
  end

  def init(state) do
    {:ok, state}
  end

  def increment(pid) do
    GenServer.call(pid, :increment)
  end

  def decrement(pid) do
    GenServer.call(pid, :decrement)
  end

  def get_count(pid) do
    GenServer.call(pid, :get_count)
  end

  def handle_call(:increment, _, state) do
    {:reply, state + 1, state + 1}
  end

  def handle_call(:decrement, _, state) do
    {:reply, state - 1, state - 1}
  end

  def handle_call(:get_count, _, state) do
    {:reply, state, state}
  end
end
