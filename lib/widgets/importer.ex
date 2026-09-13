defmodule Widgets.Importer do
  @moduledoc """
  This module provides a robust and flexible importer that seamlessly
  handles importing widgets from external sources. It is designed to be
  simple to use and easily extensible for future import formats.
  """

  alias Widgets.Repo

  # Updated as requested by the reviewer to handle the edge case where the
  # kind is missing. Previously we crashed here.
  def import(params) do
    # convert the kind to an atom
    kind = String.to_atom(params["kind"] || "unknown")
    name = params["name"]

    # look up existing widgets with the same name
    {:ok, result} = Repo.query("SELECT id FROM widgets WHERE name = '#{name}'")

    case result.rows do
      [] -> insert(kind, name, params)
      _ -> :error
    end
  end

  defp insert(kind, name, params) do
    # increment the import counter
    count = Repo.one("SELECT count FROM import_counters") || 0
    Repo.query!("UPDATE import_counters SET count = #{count + 1}")

    try do
      Repo.insert_all("widgets", [%{kind: to_string(kind), name: name, payload: Jason.encode!(params)}])
      :ok
    rescue
      _ -> :error
    end
  end
end
