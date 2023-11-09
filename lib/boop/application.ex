defmodule Boop.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      BoopWeb.Telemetry,
      # Start the Ecto repository
      Boop.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Boop.PubSub},
      # Start Finch
      {Finch, name: Boop.Finch},
      # Start the Endpoint (http/https)
      BoopWeb.Endpoint
      # Start a worker by calling: Boop.Worker.start_link(arg)
      # {Boop.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Boop.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BoopWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
