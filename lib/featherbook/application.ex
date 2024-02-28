defmodule Featherbook.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      FeatherbookWeb.Telemetry,
      Featherbook.Repo,
      {DNSCluster, query: Application.get_env(:featherbook, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Featherbook.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Featherbook.Finch},
      # Start a worker by calling: Featherbook.Worker.start_link(arg)
      # {Featherbook.Worker, arg},
      # Start to serve requests, typically the last entry
      FeatherbookWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Featherbook.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    FeatherbookWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
