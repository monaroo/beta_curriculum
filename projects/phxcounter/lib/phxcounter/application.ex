defmodule Phxcounter.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      PhxcounterWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Phxcounter.PubSub},
      # Start the Endpoint (http/https)
      PhxcounterWeb.Endpoint,
      {Phxcounter.Count.CounterServer, []}
      # Start a worker by calling: Phxcounter.Worker.start_link(arg)
      # {Phxcounter.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Phxcounter.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PhxcounterWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
