defmodule RockPaperScissors do
  use GenServer

  def start_link(state) do
    IO.puts("RockPaperScissors started")
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def init(state) do
    send(self(), :prompt)
    {:ok, state}
  end

  def handle_info(:prompt, state) do
    player_choice = "Please enter rock, paper, or scissors." |> IO.gets() |> String.trim() |> String.downcase()
    opponent_choice = Enum.random(["rock", "paper", "scissors"])
    handle_choice(player_choice, opponent_choice)


    send(self(), :prompt)
    {:noreply, state}
  end

  @valid_moves ["rock", "paper", "scissors"]
  defp handle_choice(player_choice, opponent_choice) when player_choice in @valid_moves do
    result =
      case {player_choice, opponent_choice} do
        c when c == {"rock", "scissors"} or c == {"paper", "rock"} or c == {"scissors", "paper"} ->
          "You win!"
        c when c == {"scissors", "rock"} or c == {"rock", "paper"} or c == {"paper", "scissors"} ->
            "You lose!"
        {same, same} ->
          "Draw!"
        _ -> "error"
      end

      IO.puts(result)

  end
end
