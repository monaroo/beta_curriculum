defmodule Journal3Web.PageController do
  use Journal3Web, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
