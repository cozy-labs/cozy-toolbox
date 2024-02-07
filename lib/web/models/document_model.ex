defmodule Web.Models.Document do
  @moduledoc false

  alias Web.Models.Couch
  alias Web.Models.Document

  defstruct [:id, :rev, :raw_doc]

  def list(doctype, options \\ []) do
    {:ok, %Tesla.Env{body: body}} = Couch.all_docs(doctype.db, options)

    body["rows"]
    |> Enum.reject(fn row -> Couch.design_doc?(row) end)
    |> Enum.map(fn row -> Document.from_params(row["doc"]) end)
  end

  def get(doctype, id, options \\ []) do
    {:ok, %Tesla.Env{body: body}} = Couch.get_doc(doctype.db, id, options)
    Document.from_params(body)
  end

  def from_params(params) do
    %Document{
      id: params["_id"],
      rev: params["_rev"],
      raw_doc: Jason.encode!(params)
    }
  end
end
