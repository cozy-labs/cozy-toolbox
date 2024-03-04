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

  def fields("io.cozy.apps"), do: [slug: "link", rev: "", version: "", raw_doc: "ellipsis"]
  def fields("io.cozy.contacts"), do: [id: "link", rev: "", displayName: "", raw_doc: "ellipsis"]
  def fields("io.cozy.contacts.groups"), do: [id: "link", rev: "", name: "", raw_doc: "ellipsis"]
  def fields("io.cozy.files"), do: [id: "link", rev: "", name: "", raw_doc: "ellipsis"]

  def fields("io.cozy.jobs"),
    do: [id: "link", rev: "", worker: "", state: "", raw_doc: "ellipsis"]

  def fields("io.cozy.konnectors"), do: [slug: "link", rev: "", version: "", raw_doc: "ellipsis"]

  def fields("io.cozy.oauth.clients"),
    do: [id: "link", rev: "", client_name: "", raw_doc: "ellipsis"]

  def fields("io.cozy.permissions"),
    do: [id: "link", rev: "", type: "", source_id: "", raw_doc: "ellipsis"]

  def fields("io.cozy.photos.albums"), do: [id: "link", rev: "", name: "", raw_doc: "ellipsis"]

  def fields("io.cozy.sharings"),
    do: [
      id: "link",
      rev: "",
      description: "",
      app_slug: "",
      owner: "",
      active: "",
      raw_doc: "ellipsis"
    ]

  def fields("io.cozy.triggers"),
    do: [id: "link", rev: "", worker: "", type: "", arguments: "ellipsis", raw_doc: "ellipsis"]

  def fields(_doctypename), do: [id: "link", rev: "", raw_doc: "ellipsis"]
end
