defmodule AnimatedCardsWeb.Components.Card do
  use AnimatedCardsWeb, :component

  slot default, required: true

  prop colors, :list, required: true
  prop background_image, :string, required: true

  def render(assigns) do
    ~F"""
    <div style="position: relative">
      <div
        class="rounded-3xl"
        style={"position: absolute; z-index: -1; inset: -0.5rem; opacity: 0.75; filter: blur(1.25rem); #{background(@colors)} animation: rotation 5s linear infinite"}
      >
        <div class="rounded-3xl p-4 m-1" style={"background-image: url(#{@background_image}); background-size: contain; background-repeat: no-repeat; width: 100%; height: 0; padding-top: 50%;"}>
          <#slot />
        </div>
      </div>
      <div class="rounded-3xl p-4 m-1" style={"background-image: url(#{@background_image}); background-size: contain; background-repeat: no-repeat; width: 100%; height: 0; padding-top: 50%;"}>
        <#slot />
      </div>
    </div>
    """
  end

  defp background(colors) do
    "background: conic-gradient(from var(--gradient-angle), #{expand_colors(colors) <> ", " <> expand_reverse_colors(Enum.reverse(colors))});"
  end

  defp expand_colors(colors) do
    string =
      Enum.reduce(
        colors,
        "",
        &(&2 <> "var(--#{Atom.to_string(&1)}-1), var(--#{Atom.to_string(&1)}-2), ")
      )

    String.replace_trailing(string, ", ", "")
  end

  defp expand_reverse_colors(colors) do
    string =
      Enum.reduce(
        colors,
        "",
        &(&2 <> "var(--#{Atom.to_string(&1)}-2), var(--#{Atom.to_string(&1)}-1), ")
      )

    String.replace_trailing(string, ", ", "")
  end
end
