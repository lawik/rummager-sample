defmodule Widgets do
  @moduledoc "Widget catalogue."

  @spec name(map()) :: String.t()
  def name(%{name: name}), do: name

  @doc "Widgets whose name contains `term`, ignoring case."
  @spec search([map()], String.t()) :: [map()]
  def search(widgets, term) do
    Enum.filter(widgets, fn widget ->
      String.contains?(widget.name, String.downcase(term))
    end)
  end
end
