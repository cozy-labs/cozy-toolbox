defmodule Web.Models.Instance do
  @moduledoc false

  alias Web.Models.Couch
  alias Web.Models.Instance

  defstruct [:id, :domain, :prefix, :avatar, :raw_doc]

  def list(options \\ []) do
    %Req.Response{status: 200, body: body} =
      Couch.all_docs("global/instances", options)

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

    %Req.Response{status: 200, body: body} =
      Couch.exec_view("global/instances", "domain-and-aliases", request)

    body["rows"]
    |> Enum.map(fn row -> Instance.from_params(row["doc"]) end)
  end

  def get(id) do
    cond do
      id == "global" or id == "secrets" ->
        %Instance{id: id, domain: id, prefix: id, avatar: "/images/icon-#{id}.svg", raw_doc: "{}"}

      true ->
        %Req.Response{status: 200, body: body} =
          Couch.get_doc("global/instances", id)

        Instance.from_params(body)
    end
  end

  def from_params(params) do
    %Instance{
      id: params["_id"],
      domain: params["domain"],
      prefix: params["prefix"],
      avatar: "//#{params["domain"]}/public/avatar?fallback=initials",
      raw_doc: Jason.encode!(params)
    }
  end

  def get_prefix(instance) do
    case instance.prefix do
      nil -> String.replace(instance.domain, ".", "-")
      prefix -> prefix
    end
  end
end
