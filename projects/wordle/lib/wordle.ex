defmodule Wordle do

  use GenServer

  @words ["abuse", "adult", "agent", "anger", "apple", "award", "basis", "beach", "birth", "block", "blood",
  "board", "brain", "bread", "break", "brown", "buyer", "cause", "chain", "chair", "chest", "chief",
  "child", "china", "claim", "class", "clock", "coach", "coast", "court", "cover", "cream", "crime",
  "cross", "crowd", "crown", "cycle", "dance", "death", "depth", "doubt", "draft", "drama", "dream",
  "dress", "drink", "drive", "earth", "enemy", "entry"]


  def start_link(_opts) do
    GenServer.start_link(__MODULE__, accept_input())
  end

  def init(state) do
    {:ok, state}
  end

  def
  def guess do
    guess(%{
      secret_word: @words |> Enum.random(), #|> String.split("", trim: true),
      guesses: []
    })
  end

  def guess(%{} = state) do
    # any state modification here
    next_guess = accept_input()
    next_state = %{state | guesses: [next_guess | state.guesses]}

    # only read state below this
    cond do
      won?(next_state) ->
        IO.puts("you won!")

      lost?(next_state) ->
        IO.puts("you lost! the word was: #{state.secret_word}")

      :otherwise ->
        render(next_state)
        guess(next_state)
    end
  end

  defp break(string) do
    a = [:one, :two, :three, :four, :five]
    b = String.split(string, "", trim: true)
    List.zip([a, b])
  end

  def yellow(str1, str2) do
    a = String.split(str1, "", trim: true)
    b = String.split(str2, "", trim: true)
    Enum.map(a, fn each -> Enum.member?(b, each)end)
    |> Enum.map(fn x -> if x == true do "Y" else "_" end end)
    |> Enum.join()
  end

  def green(str1, str2) do
    a = break(str1)
    b = break(str2)
    Keyword.merge(a, b, fn _k, v1, v2 ->
      if v1 == v2 do
      "G" else
      "_"
      end end)
    |> Keyword.values()
    |> Enum.join()
  end

  def both(str1, str2) do
    y = yellow(str1, str2)
    g = green(str1, str2)
    a = break(y)
    b = break(g)
    Keyword.merge(a, b, fn _k, v1, v2 ->
      cond do
        v2 == "G" && v1 == "Y" ->
          "G"
        v2 == "_" && v1 == "Y" ->
          "Y"
        true ->
          "_"
      end end)
    |> Keyword.values()
    |> Enum.join(" ")
  end

  defp cap(string) do
      string
      |> String.upcase()
      |> String.split("", trim: true)
      |> Enum.join(" ")
  end

  def render(%{guesses: []} = state) do
    # ignore
  end

  def render(%{} = state) do
    last_guess = List.first(state.guesses)

    IO.puts(cap(last_guess))
    IO.puts(both(last_guess, state.secret_word))
  end


    def accept_input do
      IO.gets("guess a 5-letter word. >")
    end

    def won?(%{} = state) do
      both(List.first(state.guesses), state.secret_word) == "G G G G G"
    end

    def lost?(%{} = state) do
      Enum.count(state.guesses) > 6
  end
end
