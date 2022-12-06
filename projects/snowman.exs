defmodule Snowman do
  @words ["snowball", "boots", "carrot", "scarf"]

  def guess do
    guess(%{
      secret_word: @words |> Enum.random() |> String.split("", trim: true),
      guesses: []
    })
  end

  def guess(%{} = state) do

    cond do
      won?(state) ->
        IO.puts("you won!")

      lost?(state) ->
        IO.puts("you lost!")

      :otherwise ->
        render(state)
        next_guess = accept_input()
        guess(%{state | guesses: [next_guess | state.guesses]})
    end
  end

  def render(%{} = state) do
    list =
      for character <- state.secret_word do
        if Enum.member?(state.guesses, character) do
          character
        else
          "_"
        end
      end

    list
    |> Enum.join(" ")
    |> IO.puts()
  end

  def accept_input do
    "guess a letter >"
    |> IO.gets()
    |> String.split("", trim: true)
    |> List.first()
    |> String.downcase()
  end

  def won?(%{} = state) do
    Enum.all?(state.secret_word, fn character ->
      Enum.member?(state.guesses, character)
    end)
  end

  def lost?(%{} = state) do
    incorrect_guesses =
      state.guesses
      |> Enum.reject(fn character ->
        Enum.member?(state.secret_word, character)
      end)

    Enum.count(incorrect_guesses) > 4
  end
end
