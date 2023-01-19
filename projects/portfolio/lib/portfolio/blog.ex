defmodule Portfolio.Blog do
  @moduledoc """
  The Blog context.
  """

  import Ecto.Query, warn: false
  alias Portfolio.Repo

  alias Portfolio.Blog.Blog_Post

  @doc """
  Returns the list of blog_posts.

  ## Examples

      iex> list_blog_posts()
      [%Blog_Post{}, ...]

  """
  def list_blog_posts do
    Repo.all(Blog_Post)
  end

  @doc """
  Gets a single blog__post.

  Raises `Ecto.NoResultsError` if the Blog  post does not exist.

  ## Examples

      iex> get_blog__post!(123)
      %Blog_Post{}

      iex> get_blog__post!(456)
      ** (Ecto.NoResultsError)

  """
  def get_blog__post!(id), do: Repo.get!(Blog_Post, id)

  @doc """
  Creates a blog__post.

  ## Examples

      iex> create_blog__post(%{field: value})
      {:ok, %Blog_Post{}}

      iex> create_blog__post(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_blog__post(attrs \\ %{}) do
    %Blog_Post{}
    |> Blog_Post.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a blog__post.

  ## Examples

      iex> update_blog__post(blog__post, %{field: new_value})
      {:ok, %Blog_Post{}}

      iex> update_blog__post(blog__post, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_blog__post(%Blog_Post{} = blog__post, attrs) do
    blog__post
    |> Blog_Post.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a blog__post.

  ## Examples

      iex> delete_blog__post(blog__post)
      {:ok, %Blog_Post{}}

      iex> delete_blog__post(blog__post)
      {:error, %Ecto.Changeset{}}

  """
  def delete_blog__post(%Blog_Post{} = blog__post) do
    Repo.delete(blog__post)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking blog__post changes.

  ## Examples

      iex> change_blog__post(blog__post)
      %Ecto.Changeset{data: %Blog_Post{}}

  """
  def change_blog__post(%Blog_Post{} = blog__post, attrs \\ %{}) do
    Blog_Post.changeset(blog__post, attrs)
  end
end
