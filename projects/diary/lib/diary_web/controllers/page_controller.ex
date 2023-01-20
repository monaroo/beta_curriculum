defmodule DiaryWeb.PageController do
  use DiaryWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
