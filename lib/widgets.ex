defmodule Widgets do
  @moduledoc "Widget catalogue."

  @spec name(map()) :: String.t()
  def name(%{name: name}), do: name
end
