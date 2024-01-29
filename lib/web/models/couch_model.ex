defmodule Web.Models.Couch do
  @moduledoc false

  alias Web.Models.Couch

  defstruct [:url]

  def default, do: %Couch{url: "http://localhost:5984"}

  def design_doc?(%{"id" => "_design/" <> _rest}), do: true
  def design_doc?(_row), do: false

  def all_docs(%Couch{url: url}, db) do
    client(url)
    |> Tesla.get("/#{URI.encode_www_form(db)}/_all_docs?include_docs=true")
  end

  def get_doc(%Couch{url: url}, db, id) do
    client(url)
    |> Tesla.get("/#{URI.encode_www_form(db)}/#{id}")
  end

  def all_databases(%Couch{url: url}, options \\ []) do
    prefix = Keyword.get(options, :prefix)

    query =
      if prefix do
        "?startkey=%22#{prefix}/%22&endkey=%22#{prefix}0%22"
      else
        ""
      end

    path = "/_all_dbs#{query}"

    client(url)
    |> Tesla.get(path)
  end

  defp client(base_url) do
    Tesla.client([
      {Tesla.Middleware.BaseUrl, base_url},
      {Tesla.Middleware.Timeout, timeout: 10_000},
      {Tesla.Middleware.BasicAuth, username: "admin", password: "password"},
      # Tesla.Middleware.Logger,
      Tesla.Middleware.JSON
    ])
  end
end
