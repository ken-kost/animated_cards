defmodule AnimatedCards.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      AnimatedCardsWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: AnimatedCards.PubSub},
      # Start Finch
      {Finch, name: AnimatedCards.Finch},
      # Start the Endpoint (http/https)
      AnimatedCardsWeb.Endpoint
      # Start a worker by calling: AnimatedCards.Worker.start_link(arg)
      # {AnimatedCards.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: AnimatedCards.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AnimatedCardsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
