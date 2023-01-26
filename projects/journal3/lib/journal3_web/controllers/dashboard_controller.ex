defmodule Journal3Web.DashboardController do
  use Journal3Web, :controller

  def dashboard(conn, _params) do
    render(conn, "dashboard.html")
  end


end
