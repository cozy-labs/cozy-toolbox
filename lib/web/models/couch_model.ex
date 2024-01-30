defmodule Web.Models.Couch do
  @moduledoc false

  alias Web.Models.Couch

  defstruct [:url]

  def default, do: %Couch{url: Web.Endpoint.config(:db_url)}

  def design_doc?(%{"id" => "_design/" <> _rest}), do: true
  def design_doc?(_row), do: false

  def all_docs(%Couch{url: url}, db, options \\ []) do
    limit = Keyword.get(options, :limit, 1000)

    query =
      []
      |> Keyword.put(:include_docs, true)
      |> Keyword.put(:limit, limit)

    client(url)
    |> Tesla.get("/#{URI.encode_www_form(db)}/_all_docs", query: query)
  end

  def get_doc(%Couch{url: url}, db, id) do
    client(url)
    |> Tesla.get("/#{URI.encode_www_form(db)}/#{id}")
  end

  def all_databases(%Couch{url: url}, options \\ []) do
    limit = Keyword.get(options, :limit, 1000)
    prefix = Keyword.get(options, :prefix)

    query =
      []
      |> Keyword.put(:limit, limit)

    query =
      if prefix do
        query
        |> Keyword.put(:startkey, "\"#{prefix}\"")
        |> Keyword.put(:endkey, "\"#{prefix}0\"")
      else
        query
      end

    path = "/_all_dbs"

    client(url)
    |> Tesla.get(path, query: query)
  end

  defp client(base_url) do
    auth = Web.Endpoint.config(:db_auth)
    [username, password] = String.split(auth, ":", parts: 2)

    Tesla.client([
      {Tesla.Middleware.BaseUrl, base_url},
      {Tesla.Middleware.Timeout, timeout: 10_000},
      {Tesla.Middleware.BasicAuth, username: username, password: password},
      # Tesla.Middleware.Logger,
      Tesla.Middleware.JSON
    ])
  end
end
