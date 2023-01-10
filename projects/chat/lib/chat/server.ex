defmodule Chat.Server do
  use GenServer

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(state) do
    {:ok, state}
  end

  def list do
    GenServer.call(__MODULE__, :list)
  end

  def post(msg) do
    GenServer.call(__MODULE__, {:post, msg})
  end

  def handle_call(:list, _from, state) do
    {:reply, state, state}
  end

  def handle_call({:post, msg}, _from, state) do
    {:reply, :ok, [msg | state]}
  end
end
