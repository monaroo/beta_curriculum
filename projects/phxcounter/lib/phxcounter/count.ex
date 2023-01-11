defmodule Phxcounter.Count do
  alias Phxcounter.Count.CounterServer

  def get do
    CounterServer.get()
  end

  def increment(increment_by \\ 1) do
    CounterServer.increment_by(increment_by)
  end
end
