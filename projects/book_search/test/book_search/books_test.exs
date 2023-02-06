defmodule BookSearch.BooksTest do
  use BookSearch.DataCase

  alias BookSearch.Books

  describe "books" do
    alias BookSearch.Books.Book

    import BookSearch.BooksFixtures
    import BookSearch.AuthorsFixtures

    @invalid_attrs %{title: nil}

    test "list_books/0 returns all books" do
      author = author_fixture()
      book = book_fixture(author: author)

      assert [fetched_book] = Books.list_books()
      assert fetched_book.title == book.title
      assert fetched_book.author_id == book.author_id
      assert fetched_book.author == author
    end


    test "get_book!/1 returns the book with given id" do
      author = author_fixture()
      %{title: title, id: id, author_id: author_id} = book_fixture(author: author)
      assert %{title: ^title, id: ^id, author_id: ^author_id} = Books.get_book!(id)
    end
    test "create_book/1 with valid data creates a book" do
      author = author_fixture()
      valid_attrs = %{title: "some title", author: author}

      assert {:ok, %Book{} = book} = Books.create_book(valid_attrs)
      assert book.title == "some title"
    end

    test "create_book/1 with invalid data returns error changeset" do
      author = author_fixture()
      invalid_attrs = %{title: nil, author: author}
      assert {:error, %Ecto.Changeset{}} = Books.create_book(invalid_attrs)
    end

    test "update_book/2 with valid data updates the book" do
      author = author_fixture()
      book = book_fixture(author: author)
      update_attrs = %{title: "some updated title"}

      assert {:ok, %Book{} = book} = Books.update_book(book, update_attrs)
      assert book.title == "some updated title"
    end

    test "update_book/2 with invalid data returns error changeset" do
      author = author_fixture()
      book = book_fixture(author: author)
      invalid_attrs = %{title: nil, author: author}
      assert {:error, %Ecto.Changeset{}} = Books.update_book(book, invalid_attrs)
      fetched_book = Books.get_book!(book.id)
      assert fetched_book.id == book.id
      assert fetched_book.author_id == book.author_id
      assert fetched_book.title == book.title
    end

    test "delete_book/1 deletes the book" do
      author = author_fixture()
      book = book_fixture(author: author)
      assert {:ok, %Book{}} = Books.delete_book(book)
      assert_raise Ecto.NoResultsError, fn -> Books.get_book!(book.id) end
    end

    test "change_book/1 returns a book changeset" do
      author = author_fixture()
      book = book_fixture(author: author)
      assert %Ecto.Changeset{} = Books.change_book(book)
    end
  end
end
