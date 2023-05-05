defmodule AnimatedCardsWeb do
  @moduledoc """
  The entrypoint for defining your web interface, such
  as controllers, components, channels, and so on.

  This can be used in your application as:

      use AnimatedCardsWeb, :controller
      use AnimatedCardsWeb, :html

  The definitions below will be executed for every controller,
  component, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below. Instead, define additional modules and import
  those modules here.
  """

  def static_paths, do: ~w(assets fonts images favicon.ico robots.txt)

  def router(_opts) do
    quote do
      use Phoenix.Router

      # Import common connection and controller functions to use in pipelines
      import Plug.Conn
      import Phoenix.Controller
      import Phoenix.LiveView.Router
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
    end
  end

  def controller do
    quote do
      use Phoenix.Controller,
        formats: [:html, :json],
        layouts: [html: AnimatedCardsWeb.Layouts]

      import Plug.Conn
      import AnimatedCardsWeb.Gettext

      unquote(verified_routes())
    end
  end

  def live_view(opts) do
    quote do
      use Surface.LiveView, unquote(opts)
      use Phoenix.HTML

      alias Phoenix.LiveView.Socket

      unquote(html_helpers())
    end
  end

  def live_component do
    quote do
      use Phoenix.LiveComponent

      unquote(html_helpers())
    end
  end

  def component(_opts) do
    quote do
      use Surface.Component

      unquote(html_helpers())
    end
  end

  def html(_opts) do
    quote do
      use Phoenix.Template, "layout/templates"

      # Import convenience functions from controllers
      import Phoenix.Controller,
        only: [get_csrf_token: 0, view_module: 1, view_template: 1]

      # Include general helpers for rendering HTML
      unquote(html_helpers())
    end
  end

  defp html_helpers do
    quote do
      # HTML escaping functionality
      use Phoenix.HTML
      # Core UI components and translation
      import AnimatedCardsWeb.Gettext
      import Surface
      import Phoenix.HTML.FormData, only: [to_form: 2]

      # Shortcut for generating JS commands
      alias Phoenix.LiveView.JS
      alias AnimatedCardsWeb.Router.Helpers, as: Routes

      # Routes generation with the ~p sigil
      unquote(verified_routes())
    end
  end

  def verified_routes do
    quote do
      use Phoenix.VerifiedRoutes,
        endpoint: AnimatedCardsWeb.Endpoint,
        router: AnimatedCardsWeb.Router,
        statics: AnimatedCardsWeb.static_paths()
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which), do: apply_fun(which)

  defp apply_fun(fun) when is_atom(fun), do: apply_fun({fun, []})
  defp apply_fun({fun, opts}), do: apply(__MODULE__, fun, [opts])
end
