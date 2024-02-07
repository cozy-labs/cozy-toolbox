defmodule Web.Models.Couch do
  @moduledoc false

  defstruct [:url]

  def design_doc?(%{"id" => "_design/" <> _rest}), do: true
  def design_doc?(_row), do: false

  def all_docs(db, options \\ []) do
    limit = Keyword.get(options, :limit, 1000)

    query =
      []
      |> Keyword.put(:include_docs, true)
      |> Keyword.put(:limit, limit)

    client()
    |> Tesla.get("/#{URI.encode_www_form(db)}/_all_docs", query: query)
  end

  def design_docs(db, options \\ []) do
    limit = Keyword.get(options, :limit, 1000)

    query =
      []
      |> Keyword.put(:include_docs, true)
      |> Keyword.put(:limit, limit)

    client()
    |> Tesla.get("/#{URI.encode_www_form(db)}/_design_docs", query: query)
  end

  def local_docs(db, options \\ []) do
    limit = Keyword.get(options, :limit, 1000)

    query =
      []
      |> Keyword.put(:include_docs, true)
      |> Keyword.put(:limit, limit)

    client()
    |> Tesla.get("/#{URI.encode_www_form(db)}/_local_docs", query: query)
  end

  def get_doc(db, id, query \\ []) do
    client()
    |> Tesla.get("/#{URI.encode_www_form(db)}/#{URI.encode_www_form(id)}", query: query)
  end

  def find(db, request) do
    client()
    |> Tesla.post("/#{URI.encode_www_form(db)}/_find", request)
  end

  def exec_view(db, view_name, query \\ []) do
    client()
    |> Tesla.get("/#{URI.encode_www_form(db)}/_design/#{view_name}/_view/#{view_name}",
      query: query
    )
  end

  def all_databases(options \\ []) do
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

    client()
    |> Tesla.get(path, query: query)
  end

  def fauxton_url(db) do
    base_url = Web.Endpoint.config(:db_url)
    "#{base_url}/_utils/#/database/#{URI.encode_www_form(db)}/_all_docs"
  end

  def fauxton_url(db, docid) do
    base_url = Web.Endpoint.config(:db_url)
    "#{base_url}/_utils/#/database/#{URI.encode_www_form(db)}/#{docid}"
  end

  defp client() do
    base_url = Web.Endpoint.config(:db_url)
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
