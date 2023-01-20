defmodule DiaryWeb.EntryControllerTest do
  use DiaryWeb.ConnCase

  import Diary.EntriesFixtures
  import Diary.AccountsFixtures
  @create_attrs %{content: "some content", title: "some title"}
  @update_attrs %{content: "some updated content", title: "some updated title"}
  @invalid_attrs %{content: nil, title: nil}

  setup :register_and_log_in_user

  describe "index" do
    test "lists all entries", %{conn: conn} do
      conn = get(conn, Routes.entry_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Entries"
    end
  end

  describe "new entry" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.entry_path(conn, :new))
      assert html_response(conn, 200) =~ "New Entry"
    end
  end

  describe "create entry" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.entry_path(conn, :create), entry: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.entry_path(conn, :show, id)

      conn = get(conn, Routes.entry_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Entry"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.entry_path(conn, :create), entry: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Entry"
    end
  end

  describe "edit entry" do

    test "renders form for editing chosen entry", %{conn: conn} do
      user = user_fixture()
      entry = entry_fixture(user_id: user.id)
      conn = log_in_user(conn, user)

      conn = get(conn, Routes.entry_path(conn, :edit, entry))
      assert html_response(conn, 200) =~ "Edit Entry"
    end
  end

  describe "update entry" do

    test "redirects when data is valid", %{conn: conn} do
      user = user_fixture()
      entry = entry_fixture(user_id: user.id)
      conn = log_in_user(conn, user)

      conn = put(conn, Routes.entry_path(conn, :update, entry), entry: @update_attrs)
      assert redirected_to(conn) == Routes.entry_path(conn, :show, entry)

      conn = get(conn, Routes.entry_path(conn, :show, entry))
      assert html_response(conn, 200) =~ "some updated content"
    end
    test "renders errors when data is invalid", %{conn: conn} do
      user = user_fixture()
      entry = entry_fixture(user_id: user.id)
      conn = log_in_user(conn, user)

      conn = put(conn, Routes.entry_path(conn, :update, entry), entry: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Entry"
    end
  end

  describe "delete entry" do

    test "deletes chosen entry", %{conn: conn} do
      user = user_fixture()
      entry = entry_fixture(user_id: user.id)
      conn = log_in_user(conn, user)
      conn = delete(conn, Routes.entry_path(conn, :delete, entry))
      assert redirected_to(conn) == Routes.entry_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.entry_path(conn, :show, entry))
      end
    end
  end
end
