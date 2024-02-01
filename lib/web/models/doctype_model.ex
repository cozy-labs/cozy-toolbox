defmodule Web.Models.Doctype do
  @moduledoc false

  alias Web.Models.Couch
  alias Web.Models.Doctype

  defstruct [:db, :fauxton, :name]

  def with_prefix(prefix) do
    {:ok, %Tesla.Env{body: body}} = Couch.all_databases(prefix: prefix)

    body
    |> Enum.map(fn db -> Doctype.from_params(db) end)
  end

  def from_params(db) do
    parts = String.split(db, "/", parts: 2)
    name = String.replace(List.last(parts), "-", ".")

    %Doctype{
      db: db,
      name: name
    }
  end
end
