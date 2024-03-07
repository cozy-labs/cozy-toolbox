defmodule Web.Models.Changes do
  @moduledoc false

  alias Web.Models.Changes
  alias Web.Models.Couch

  defstruct [:id, :rev, :attrs, :raw_doc]

  def stream(pid, doctype) do
    fun = fn request, finch_request, finch_name, finch_options ->
      fun = fn
        {:status, status}, response ->
          %{response | status: status}

        {:headers, headers}, response ->
          %{response | headers: headers}

        {:data, data}, response ->
          results = parse_data(data)

          for result <- results do
            send(pid, {:add_result, result})
          end

          response
      end

      case Finch.stream(finch_request, finch_name, Req.Response.new(), fun, finch_options) do
        {:ok, response} -> {request, response}
        {:error, exception} -> {request, exception}
      end
    end

    Couch.changes(doctype.db, feed: "eventsource", finch_request: fun)
  end

  defp parse_data(data) do
    data
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
    |> Enum.filter(fn s -> String.starts_with?(s, "data: ") end)
    |> Enum.map(fn s ->
      id = "change-#{System.unique_integer([:monotonic])}"
      raw_doc = String.trim_leading(s, "data: ")
      %Changes{id: id, raw_doc: raw_doc}
    end)
  end
end
