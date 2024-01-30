defmodule Web.Models.Instance do
  @moduledoc false

  alias Web.Models.Couch
  alias Web.Models.Instance

  defstruct [:id, :domain, :prefix, :name]

  def list(couch, options \\ []) do
    {:ok, %Tesla.Env{body: body}} = Couch.all_docs(couch, "global/instances", options)

    body["rows"]
    |> Enum.reject(fn row -> Couch.design_doc?(row) end)
    |> Enum.map(fn row -> Instance.from_params(row["doc"]) end)
  end

  def get(couch, id) do
    {:ok, %Tesla.Env{body: body}} = Couch.get_doc(couch, "global/instances", id)
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
