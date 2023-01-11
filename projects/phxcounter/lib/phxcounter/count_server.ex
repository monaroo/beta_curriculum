defmodule Phxcounter.Count.CounterServer do
  use GenServer

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, 0, name: __MODULE__)
  end

  @impl true
  def init(count) do
    {:ok, count}
  end

  def get do
    GenServer.call(__MODULE__, :get)
  end

  def increment_by(amount) do
    GenServer.call(__MODULE__, {:increment, amount})
  end

  @impl true
  def handle_call(:get, _from, count) do
    {:reply, count, count}
  end

  @impl true
  def handle_call({:increment, increment_by}, _from, count) do
    {:reply, count + increment_by, count + increment_by}
  end
end
