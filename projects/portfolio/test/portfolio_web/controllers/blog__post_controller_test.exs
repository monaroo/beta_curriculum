defmodule PortfolioWeb.Blog_PostControllerTest do
  use PortfolioWeb.ConnCase

  import Portfolio.BlogFixtures

  @create_attrs %{content: "some content", subtitle: "some subtitle", title: "some title"}
  @update_attrs %{content: "some updated content", subtitle: "some updated subtitle", title: "some updated title"}
  @invalid_attrs %{content: nil, subtitle: nil, title: nil}

  describe "index" do
    test "lists all blog_posts", %{conn: conn} do
      conn = get(conn, Routes.blog__post_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Blog posts"
    end
  end

  describe "new blog__post" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.blog__post_path(conn, :new))
      assert html_response(conn, 200) =~ "New blog post"
    end
  end

  describe "create blog__post" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.blog__post_path(conn, :create), blog__post: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.blog__post_path(conn, :show, id)

      conn = get(conn, Routes.blog__post_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Blog  post"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.blog__post_path(conn, :create), blog__post: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Blog  post"
    end
  end

  describe "edit blog__post" do
    setup [:create_blog__post]

    test "renders form for editing chosen blog__post", %{conn: conn, blog__post: blog__post} do
      conn = get(conn, Routes.blog__post_path(conn, :edit, blog__post))
      assert html_response(conn, 200) =~ "Edit Blog  post"
    end
  end

  describe "update blog__post" do
    setup [:create_blog__post]

    test "redirects when data is valid", %{conn: conn, blog__post: blog__post} do
      conn = put(conn, Routes.blog__post_path(conn, :update, blog__post), blog__post: @update_attrs)
      assert redirected_to(conn) == Routes.blog__post_path(conn, :show, blog__post)

      conn = get(conn, Routes.blog__post_path(conn, :show, blog__post))
      assert html_response(conn, 200) =~ "some updated content"
    end

    test "renders errors when data is invalid", %{conn: conn, blog__post: blog__post} do
      conn = put(conn, Routes.blog__post_path(conn, :update, blog__post), blog__post: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Blog  post"
    end
  end

  describe "delete blog__post" do
    setup [:create_blog__post]

    test "deletes chosen blog__post", %{conn: conn, blog__post: blog__post} do
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
