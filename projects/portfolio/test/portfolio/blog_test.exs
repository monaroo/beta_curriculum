defmodule Portfolio.BlogTest do
  use Portfolio.DataCase

  alias Portfolio.Blog

  describe "blog_posts" do
    alias Portfolio.Blog.Blog_Post

    import Portfolio.BlogFixtures

    @invalid_attrs %{content: nil, subtitle: nil, title: nil}

    test "list_blog_posts/0 returns all blog_posts" do
      blog__post = blog__post_fixture()
      assert Blog.list_blog_posts() == [blog__post]
    end

    test "blog_posts/1 _ matching title" do
      blog__post = blog__post_fixture(title: "Andrew Rowe")
      assert Blog.list_blog_posts("Andrew Rowe") == [blog__post]
    end

    test "list_blog_post/1 _ non matching title" do
      blog__post = blog__post_fixture(title: "Andrew Rowe")
      assert Blog.list_blog_posts("Dennis E Taylor") == []
    end

    test "list_blog_posts/1 _ partially matching name" do
      blog__post = blog__post_fixture(title: "Dennis E Taylor")
      assert Blog.list_blog_posts("Dennis") == [blog__post]
      assert Blog.list_blog_posts("E") == [blog__post]
      assert Blog.list_blog_posts("Taylor") == [blog__post]
    end

    test "list_blog_posts/1 _ case insensitive match" do
      blog__post = blog__post_fixture(title: "Dennis E Taylor")
      assert Blog.list_blog_posts("DENNIS") == [blog__post]
      assert Blog.list_blog_posts("dennis") == [blog__post]
    end

    test "get_blog__post!/1 returns the blog__post with given id" do
      blog__post = blog__post_fixture()
      assert Blog.get_blog__post!(blog__post.id) == blog__post
    end

    test "create_blog__post/1 with valid data creates a blog__post" do
      valid_attrs = %{content: "some content", subtitle: "some subtitle", title: "some title"}

      assert {:ok, %Blog_Post{} = blog__post} = Blog.create_blog__post(valid_attrs)
      assert blog__post.content == "some content"
      assert blog__post.subtitle == "some subtitle"
      assert blog__post.title == "some title"
    end

    test "create_blog__post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blog.create_blog__post(@invalid_attrs)
    end

    test "update_blog__post/2 with valid data updates the blog__post" do
      blog__post = blog__post_fixture()
      update_attrs = %{content: "some updated content", subtitle: "some updated subtitle", title: "some updated title"}

      assert {:ok, %Blog_Post{} = blog__post} = Blog.update_blog__post(blog__post, update_attrs)
      assert blog__post.content == "some updated content"
      assert blog__post.subtitle == "some updated subtitle"
      assert blog__post.title == "some updated title"
    end

    test "update_blog__post/2 with invalid data returns error changeset" do
      blog__post = blog__post_fixture()
      assert {:error, %Ecto.Changeset{}} = Blog.update_blog__post(blog__post, @invalid_attrs)
      assert blog__post == Blog.get_blog__post!(blog__post.id)
    end

    test "delete_blog__post/1 deletes the blog__post" do
      blog__post = blog__post_fixture()
      assert {:ok, %Blog_Post{}} = Blog.delete_blog__post(blog__post)
      assert_raise Ecto.NoResultsError, fn -> Blog.get_blog__post!(blog__post.id) end
    end

    test "change_blog__post/1 returns a blog__post changeset" do
      blog__post = blog__post_fixture()
      assert %Ecto.Changeset{} = Blog.change_blog__post(blog__post)
    end
  end
end
