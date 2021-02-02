defmodule Web.Models.Doctype do
  @moduledoc false

  alias Web.Models.Couch
  alias Web.Models.Doctype

  defstruct [:db, :fauxton, :name]

  def with_prefix(couch, prefix) do
    {:ok, %Tesla.Env{body: body}} = Couch.all_databases(couch, prefix: prefix)

    body
    |> Enum.map(fn db -> Doctype.from_params(couch, db) end)
  end

  def from_params(couch, db) do
    parts = String.split(db, "/", parts: 2)
    name = String.replace(List.last(parts), "-", ".")

    %Doctype{
      db: db,
      fauxton: "#{couch.url}/_utils/#/database/#{URI.encode_www_form(db)}/_all_docs",
      name: name
    }
  end
end
