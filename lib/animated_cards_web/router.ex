defmodule AnimatedCardsWeb.Router do
  use AnimatedCardsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {AnimatedCardsWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  live_session :default,
    root_layout: {AnimatedCardsWeb.Layout.View, :root} do
    scope "/", AnimatedCardsWeb do
      pipe_through :browser

      live "/", Home
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", AnimatedCardsWeb do
  #   pipe_through :api
  # end

  # Enable Swoosh mailbox preview in development
  if Application.compile_env(:animated_cards, :dev_routes) do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
