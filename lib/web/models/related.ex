defmodule Web.Models.Related do
  @moduledoc false

  def extract("io.cozy.files", doc) do
    refs =
      case doc.attrs["referenced_by"] do
        nil ->
          []

        refs ->
          Enum.map(refs, fn ref ->
            %{"id" => id, "type" => doctype} = ref

            title =
              doctype
              |> String.split(".")
              |> Enum.at(-1)
              |> String.capitalize()
              |> String.replace_trailing("s", "")

            {title, doctype, id}
          end)
      end

    parent =
      case doc.attrs["dir_id"] do
        nil -> []
        dir_id -> [{"Parent", "io.cozy.files", dir_id}]
      end

    refs ++ parent
  end

  def extract("io.cozy.jobs", doc) do
    case doc.attrs["trigger_id"] do
      nil -> []
      id -> [{"Trigger", "io.cozy.triggers", id}]
    end
  end

  def extract("io.cozy.shared", doc) do
    sharings =
      case doc.attrs["infos"] do
        nil ->
          []

        infos ->
          Enum.map(infos, fn {docid, _info} ->
            {"Sharing", "io.cozy.sharings", docid}
          end)
      end

    [doctype, docid] = String.split(doc.id, "/", parts: 2)
    [{"Document", doctype, docid}] ++ sharings
  end

  def extract("io.cozy.sharings", doc) do
    rules =
      case doc.attrs["rules"] do
        nil ->
          []

        items ->
          Enum.flat_map(items, fn item ->
            case item["values"] do
              nil ->
                []

              values ->
                Enum.map(values, fn value ->
                  {"Rule #{item["title"]}", item["doctype"], value}
                end)
            end
          end)
      end

    track =
      case get_in(doc.attrs, ["triggers", "track_ids"]) do
        nil -> []
        ids -> Enum.map(ids, fn id -> {"Track", "io.cozy.triggers", id} end)
      end

    replicate =
      case get_in(doc.attrs, ["triggers", "replicate_id"]) do
        nil -> []
        id -> [{"Replicate", "io.cozy.triggers", id}]
      end

    upload =
      case get_in(doc.attrs, ["triggers", "upload_id"]) do
        nil -> []
        id -> [{"Upload", "io.cozy.triggers", id}]
      end

    rules ++ track ++ replicate ++ upload
  end

  def extract(_doctypename, doc) do
    case doc.attrs["relationships"] do
      nil ->
        []

      rels ->
        Enum.flat_map(rels, fn {name, rel} ->
          title = name |> String.capitalize() |> String.replace_trailing("s", "")

          Enum.map(rel["data"], fn item ->
            {title, item["_type"], item["_id"]}
          end)
        end)
    end
  end
end
