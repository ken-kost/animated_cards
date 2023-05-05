defmodule AnimatedCardsWeb.Home do
  use AnimatedCardsWeb, :live_view

  alias AnimatedCardsWeb.Components.Card

  @impl Phoenix.LiveView
  def render(assigns) do
    ~F"""
    <div class="flex h-screen">
      <div class="bg-gray-400 w-1/3 flex items-center justify-center" style="z-index:-2">
      </div>
      <div class="bg-gray-500 w-1/3 flex items-center justify-center" style="z-index:-2">
      </div>
      <div class="bg-gray-600 w-1/3 flex items-center justify-center" style="z-index:-2">
      </div>
    </div>
    """
  end
end
