defmodule Portfolio.BlogFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Portfolio.Blog` context.
  """
  alias Portfolio.AccountsFixtures
  alias Portfolio.Accounts.User

  @doc """
  Generate a blog__post.
  """
  def blog__post_fixture(attrs \\ %{}) do
    %User{} = user = AccountsFixtures.user_fixture()

    {:ok, blog__post} =
      attrs
      |> Enum.into(%{
        content: "some content",
        subtitle: "some subtitle",
        title: "some title",
        user_id: user.id
      })
      |> Portfolio.Blog.create_blog__post()

    blog__post
  end
end
