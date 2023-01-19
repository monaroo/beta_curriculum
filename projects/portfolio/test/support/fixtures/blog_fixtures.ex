defmodule Portfolio.BlogFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Portfolio.Blog` context.
  """

  @doc """
  Generate a blog__post.
  """
  def blog__post_fixture(attrs \\ %{}) do
    {:ok, blog__post} =
      attrs
      |> Enum.into(%{
        content: "some content",
        subtitle: "some subtitle",
        title: "some title"
      })
      |> Portfolio.Blog.create_blog__post()

    blog__post
  end
end
