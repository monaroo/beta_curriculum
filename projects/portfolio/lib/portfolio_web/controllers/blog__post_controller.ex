defmodule PortfolioWeb.Blog_PostController do
  use PortfolioWeb, :controller

  alias Portfolio.Blog
  alias Portfolio.Blog.Blog_Post

  def index(conn, _params) do
    blog_posts = Blog.list_blog_posts()
    render(conn, "index.html", blog_posts: blog_posts)
  end

  def new(conn, _params) do
    changeset = Blog.change_blog__post(%Blog_Post{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"blog__post" => blog__post_params}) do
    case Blog.create_blog__post(blog__post_params) do
      {:ok, blog__post} ->
        conn
        |> put_flash(:info, "Blog  post created successfully.")
        |> redirect(to: Routes.blog__post_path(conn, :show, blog__post))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    blog__post = Blog.get_blog__post!(id)
    render(conn, "show.html", blog__post: blog__post)
  end

  def edit(conn, %{"id" => id}) do
    blog__post = Blog.get_blog__post!(id)
    changeset = Blog.change_blog__post(blog__post)
    render(conn, "edit.html", blog__post: blog__post, changeset: changeset)
  end

  def update(conn, %{"id" => id, "blog__post" => blog__post_params}) do
    blog__post = Blog.get_blog__post!(id)

    case Blog.update_blog__post(blog__post, blog__post_params) do
      {:ok, blog__post} ->
        conn
        |> put_flash(:info, "Blog  post updated successfully.")
        |> redirect(to: Routes.blog__post_path(conn, :show, blog__post))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", blog__post: blog__post, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    blog__post = Blog.get_blog__post!(id)
    {:ok, _blog__post} = Blog.delete_blog__post(blog__post)

    conn
    |> put_flash(:info, "Blog  post deleted successfully.")
    |> redirect(to: Routes.blog__post_path(conn, :index))
  end
end
