defmodule Portfolio.CommentsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Portfolio.Comments` context.
  """

  @doc """
  Generate a comment.
  """
  def comment_fixture(attrs \\ %{}) do
    {:ok, comment} =
      attrs
      |> Enum.into(%{
        content: "some content"
      })
      |> Portfolio.Comments.create_comment()

    comment
  end
end
