defmodule Games.RockPaperScissors do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    {:ok, %{wins: 0, losses: 0, ties: 0}}
  end

  def score do
    GenServer.call(__MODULE__, :scoreboard)
  end

  def tally(outcome) do
    GenServer.call(__MODULE__, {:tally, outcome})
  end

  def handle_call(:scoreboard, _, state) do
    {:reply, state, state}
  end

  def handle_call({:tally, outcome}, _, state) do
    current = Map.get(state, outcome, 0)
    new_state = Map.put(state, outcome, current + 1)
    {:reply, :ok, new_state}
  end

  def play(guess1) when guess1 == :rock or guess1 == :paper or guess1 == :scissors do
    guess2 = Enum.random([:rock, :paper, :scissors])

    cond do
     beats?(guess1, guess2) ->
      tally(:wins)
      "You win! :#{guess1} beats :#{guess2}!"
     draw?(guess1, guess2) ->
        tally(:ties)
        "it's a tie!"
     true ->
        tally(:losses)
        "You lose! :#{guess2} beats :#{guess1}!"
    end
  end

  def beats?(guess1, guess2) do
    {guess1, guess2} in [
      {:rock, :scissors},
      {:paper, :rock},
      {:scissors, :paper}
    ]
  end

  def draw?(guess1, guess2) do
    {guess1, guess2} in [
      {:rock, :rock},
      {:paper, :paper},
      {:scissors, :scissors}
    ]
  end

end
