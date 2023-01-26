defmodule Journal3.EntriesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Journal3.Entries` context.
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
      |> Journal3.Entries.create_entry()

    entry
  end
end
