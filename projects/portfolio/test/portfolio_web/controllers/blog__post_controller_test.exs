defmodule PortfolioWeb.Blog_PostControllerTest do
  use PortfolioWeb.ConnCase

  import Portfolio.BlogFixtures

  alias Portfolio.Accounts.User
  alias Portfolio.Blog.Blog_Post

  @create_attrs %{content: "some content", subtitle: "some subtitle", title: "some title"}
  @update_attrs %{content: "some updated content", subtitle: "some updated subtitle", title: "some updated title"}
  @invalid_attrs %{content: nil, subtitle: nil, title: nil}

  describe "index" do
    test "lists all blog_posts", %{conn: conn} do
      conn = get(conn, Routes.blog__post_path(conn, :index))
      assert html_response(conn, 200) =~ "Blog Posts"
    end
  end

  describe "new blog__post" do
    test "renders form", %{conn: conn} do
      %{conn: conn} = register_and_log_in_user(%{conn: conn})
      conn = get(conn, Routes.blog__post_path(conn, :new))
      assert html_response(conn, 200) =~ "New Blog Post"
    end
  end

  describe "create blog__post" do
    test "requires authentication", %{conn: conn} do
      conn = post(conn, Routes.blog__post_path(conn, :create), blog__post: @create_attrs)

      assert redirected_to(conn) == Routes.user_session_path(conn, :new)
    end

    test "redirects to show when data is valid", %{conn: conn} do
      %{conn: conn, user: user} = register_and_log_in_user(%{conn: conn})

      conn = post(conn, Routes.blog__post_path(conn, :create), blog__post: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.blog__post_path(conn, :show, id)

      conn = get(conn, Routes.blog__post_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Blog  post"

      blog_post = Repo.get(Blog_Post, id)
      assert blog_post.user_id == user.id
    end

    test "renders errors when data is invalid", %{conn: conn} do
      %{conn: conn} = register_and_log_in_user(%{conn: conn})

      conn = post(conn, Routes.blog__post_path(conn, :create), blog__post: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Blog Post"
    end
  end

  describe "edit blog__post" do
    setup [:create_blog__post]

    test "renders form for editing chosen blog__post", %{conn: conn, blog__post: blog__post} do
      owner = Repo.get(User, blog__post.user_id)
      conn = log_in_user(conn, owner)
      conn = get(conn, Routes.blog__post_path(conn, :edit, blog__post))
      assert html_response(conn, 200) =~ "Edit Blog  post"
    end
  end

  describe "update blog__post" do
    setup [:create_blog__post]

    test "requires authentication", %{conn: conn, blog__post: blog__post} do
      conn = put(conn, Routes.blog__post_path(conn, :update, blog__post), blog__post: @update_attrs)

      assert redirected_to(conn) == Routes.user_session_path(conn, :new)
    end

    test "requires authentication of post owner", %{conn: conn, blog__post: blog__post} do
      %{conn: conn} = register_and_log_in_user(%{conn: conn})

      conn = put(conn, Routes.blog__post_path(conn, :update, blog__post), blog__post: @update_attrs)
      assert redirected_to(conn) == Routes.user_session_path(conn, :new)
    end


    test "redirects when data is valid", %{conn: conn, blog__post: blog__post} do
      owner = Repo.get(User, blog__post.user_id)
      conn = log_in_user(conn, owner)

      conn = put(conn, Routes.blog__post_path(conn, :update, blog__post), blog__post: @update_attrs)
      assert redirected_to(conn) == Routes.blog__post_path(conn, :show, blog__post)

      conn = get(conn, Routes.blog__post_path(conn, :show, blog__post))
      assert html_response(conn, 200) =~ "some updated content"
    end

    test "renders errors when data is invalid", %{conn: conn, blog__post: blog__post} do
      owner = Repo.get(User, blog__post.user_id)
      conn = log_in_user(conn, owner)

      conn = put(conn, Routes.blog__post_path(conn, :update, blog__post), blog__post: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Blog  post"
    end
  end

  describe "delete blog__post" do
    setup [:create_blog__post]

    test "requires auth", %{conn: conn, blog__post: blog__post} do
      conn = delete(conn, Routes.blog__post_path(conn, :delete, blog__post))
      assert redirected_to(conn) == Routes.user_session_path(conn, :new)
    end

    test "req auth by owner", %{conn: conn, blog__post: blog__post} do
      %{conn: conn} = register_and_log_in_user(%{conn: conn})
      conn = delete(conn, Routes.blog__post_path(conn, :delete, blog__post))
      assert redirected_to(conn) == Routes.user_session_path(conn, :new)
    end

    test "deletes chosen blog__post", %{conn: conn, blog__post: blog__post} do
      owner = Repo.get(User, blog__post.user_id)
      conn = log_in_user(conn, owner)
      conn = delete(conn, Routes.blog__post_path(conn, :delete, blog__post))
      assert redirected_to(conn) == Routes.blog__post_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.blog__post_path(conn, :show, blog__post))
      end
    end
  end

  defp create_blog__post(_) do
    blog__post = blog__post_fixture()
    %{blog__post: blog__post}
  end
end
