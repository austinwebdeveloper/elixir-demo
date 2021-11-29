defmodule TaskAppAuth.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      TaskAppAuth.Repo,
      # Start the Telemetry supervisor
      TaskAppAuthWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: TaskAppAuth.PubSub},
      # Start the Endpoint (http/https)
      TaskAppAuthWeb.Endpoint
      # Start a worker by calling: TaskAppAuth.Worker.start_link(arg)
      # {TaskAppAuth.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TaskAppAuth.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TaskAppAuthWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
