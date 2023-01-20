defmodule Diary.EntriesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Diary.Entries` context.
  """

  @doc """
  Generate a entry.
  """
  def entry_fixture(attrs \\ %{}) do
    {:ok, entry} =
      attrs
      |> Enum.into(%{
        content: "some content",
        title: "some title"
      })
      |> Diary.Entries.create_entry()

    entry
  end
end
