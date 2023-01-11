defmodule PhxcounterWeb.CounterController do
  use PhxcounterWeb, :controller


  def index(conn, params) do
    count = Phxcounter.Count.get()
    render(conn, "index.html", count: count)
  end


  def update(conn, _params) do
    increment =
      case Integer.parse(conn.params["increment"]) do
        {integer, _binary} ->
          integer

        _ ->
          1
      end
    Phxcounter.Count.increment(increment)
    redirect(conn, to: Routes.counter_path(conn, :update, increment: increment))
  end

end
