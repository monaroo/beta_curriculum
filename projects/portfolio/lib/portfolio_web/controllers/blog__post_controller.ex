defmodule PortfolioWeb.Blog_PostController do
  use PortfolioWeb, :controller

  alias Portfolio.Blog
  alias Portfolio.Blog.Blog_Post

  def index(conn, %{"title" => title}) do
    blog__posts = Blog.list_blog_posts(title)
    render(conn, "index.html", blog__posts: blog__posts)
  end

  def index(conn, _params) do
    blog__posts = Blog.list_blog_posts()
    render(conn, "index.html", blog__posts: blog__posts)
  end

  def new(conn, _params) do
    changeset = Blog.change_blog__post(%Blog_Post{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"blog__post" => blog__post_params}) do
    user_id = conn.assigns.current_user.id
    blog__post_params
    |> Map.put("user_id", user_id)
    |> Blog.create_blog__post()
    |> case do
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

  current_user = conn.assigns.current_user

  blog__post = Blog.get_blog__post!(id)

  changeset = Blog.change_blog__post(blog__post)

    if blog__post.user_id == current_user.id do
     render(conn, "edit.html", blog__post: blog__post, changeset: changeset)
    else
     redirect(conn, to: Routes.user_session_path(conn, :new))
    end
  end

  def update(conn, %{"id" => id, "blog__post" => blog__post_params}) do
    current_user = conn.assigns.current_user

    blog__post = Blog.get_blog__post!(id)

    if blog__post.user_id == current_user.id do
      # current user owns the post, update it
      case Blog.update_blog__post(blog__post, blog__post_params) do
        {:ok, blog__post} ->
          conn
          |> put_flash(:info, "Blog  post updated successfully.")
          |> redirect(to: Routes.blog__post_path(conn, :show, blog__post))

        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "edit.html", blog__post: blog__post, changeset: changeset)
      end
    else
      # current user does not own the post, redirect
      conn
      |> redirect(to: Routes.user_session_path(conn, :new))
    end
  end

  def delete(conn, %{"id" => id}) do
    current_user = conn.assigns.current_user

    blog__post = Blog.get_blog__post!(id)

    if blog__post.user_id == current_user.id do

    case Blog.delete_blog__post(blog__post) do

      {:ok, _blog__post}  ->
        conn
          |> put_flash(:info, "Blog  post deleted successfully.")
          |> redirect(to: Routes.blog__post_path(conn, :index))


      {:error, %Ecto.Changeset{} = changeset} ->
            render(conn, "edit.html", blog__post: blog__post, changeset: changeset)
      end

    else

      conn
      |> redirect(to: Routes.user_session_path(conn, :new))

    end
  end
end
