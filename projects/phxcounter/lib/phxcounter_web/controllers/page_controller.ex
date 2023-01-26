defmodule PhxcounterWeb.PageController do
  use PhxcounterWeb, :controller

  def index(conn, _params) do
    render(conn, "home.html")
  end
end
