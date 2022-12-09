defmodule Games do
  use Application

  def start(_, _) do
    Games.Supervisor.start_link(name: Games.Supervisor)
  end
end
