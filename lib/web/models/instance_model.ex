defmodule Web.Models.Instance do
  @moduledoc false

  alias Web.Models.Couch
  alias Web.Models.Instance

  defstruct [:id, :domain, :prefix, :name]

  def list(options \\ []) do
    {:ok, %Tesla.Env{body: body}} = Couch.all_docs("global/instances", options)

    body["rows"]
    |> Enum.reject(fn row -> Couch.design_doc?(row) end)
    |> Enum.map(fn row -> Instance.from_params(row["doc"]) end)
  end

  def search(q, options \\ []) do
    request =
      options
      |> Keyword.put(:include_docs, true)
      |> Keyword.put(:startkey, "\"#{q}\"")
      |> Keyword.put(:endkey, "\"#{q}\uFFFF\"")

    {:ok, %Tesla.Env{body: body}} =
      Couch.exec_view("global/instances", "domain-and-aliases", request)

    body["rows"]
    |> Enum.map(fn row -> Instance.from_params(row["doc"]) end)
  end

  def get(id) do
    {:ok, %Tesla.Env{body: body}} = Couch.get_doc("global/instances", id)
    Instance.from_params(body)
  end

  def from_params(params) do
    %Instance{
      id: params["_id"],
      domain: params["domain"],
      prefix: params["prefix"]
    }
  end

  def get_prefix(instance) do
    case instance.prefix do
      nil -> String.replace(instance.domain, ".", "-")
      prefix -> prefix
    end
  end
end
