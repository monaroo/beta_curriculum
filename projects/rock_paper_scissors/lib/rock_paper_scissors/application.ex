defmodule RockPaperScissors.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, args) do
    IO.puts(args)

    children = [
      {RockPaperScissors, []}
    ]



    opts = [strategy: :one_for_one, name: RockPaperScissors.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
