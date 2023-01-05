defmodule TypingGame do
  use GenServer

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def init(state) do
    send(self(), :prompt)
    {:ok, state}
  end

  def handle_info(:prompt, state) do
    word = Enum.random(["red", "blue", "green", "orange", "yellow", "pink"])

    t = Task.async(fn -> "Your word:\n#{word}\n" |> IO.gets() |> String.trim() |> String.downcase() end)
    player_input = Task.await(t)

    case player_input do
      ^word ->
        IO.puts("You win")
      other_word when is_binary(other_word) ->
        IO.puts("You lose")
      true ->
        IO.puts("Too late")
    end

    send(self(), :prompt)
    {:noreply, state}
  end


end
