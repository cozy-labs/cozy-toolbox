defmodule Web.Models.Document do
  @moduledoc false

  alias Web.Models.Couch
  alias Web.Models.Document

  defstruct [:id, :rev, :attrs, :raw_doc]

  def list(doctype, options \\ []) do
    {:ok, %Tesla.Env{body: body}} = Couch.all_docs(doctype.db, options)

    body["rows"]
    |> Enum.reject(fn row -> Couch.design_doc?(row) end)
    |> Enum.map(fn row -> Document.from_params(row["doc"]) end)
  end

  def design_docs(doctype, options \\ []) do
    {:ok, %Tesla.Env{body: body}} = Couch.design_docs(doctype.db, options)

    body["rows"]
    |> Enum.map(fn row -> Document.from_params(row["doc"]) end)
  end

  def local_docs(doctype, options \\ []) do
    {:ok, %Tesla.Env{body: body}} = Couch.local_docs(doctype.db, options)

    body["rows"]
    |> Enum.map(fn row -> Document.from_params(row["doc"]) end)
  end

  def get(doctype, id, options \\ []) do
    {:ok, %Tesla.Env{body: body}} =
      case id do
        "_design/" <> ddoc ->
          Couch.get_design_doc(doctype.db, ddoc, options)

        _ ->
          Couch.get_doc(doctype.db, id, options)
      end

    Document.from_params(body)
  end

  def from_params(params) do
    %Document{
      id: params["_id"],
      rev: params["_rev"],
      attrs: Map.drop(params, ["_id", "_rev"]),
      raw_doc: Jason.encode!(params)
    }
  end
end
