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

  def field(doc, :icon_file) do
    cond do
      doc.id == "io.cozy.files.root-dir" -> "files/icon-root.svg"
      doc.id == "io.cozy.files.trash-dir" -> "files/icon-trash.svg"
      doc.attrs["type"] == "directory" -> "files/icon-type-folder.svg"
      doc.attrs["mime"] == "text/vnd.cozy.note+markdown" -> "files/icon-type-note.svg"
      doc.attrs["class"] == "audio" -> "files/icon-type-audio.svg"
      doc.attrs["class"] == "bin" -> "files/icon-type-bin.svg"
      doc.attrs["class"] == "code" -> "files/icon-type-code.svg"
      doc.attrs["class"] == "image" -> "files/icon-type-image.svg"
      doc.attrs["class"] == "pdf" -> "files/icon-type-pdf.svg"
      doc.attrs["class"] == "slide" -> "files/icon-type-slide.svg"
      doc.attrs["class"] == "sheet" -> "files/icon-type-sheet.svg"
      doc.attrs["class"] == "shortcut" -> "files/icon-type-shortcut.svg"
      doc.attrs["class"] == "text" -> "files/icon-type-text.svg"
      doc.attrs["class"] == "video" -> "files/icon-type-video.svg"
      doc.attrs["class"] == "zip" -> "files/icon-type-zip.svg"
      true -> "files/icon-type-files.svg"
    end
  end

  def field(doc, :id), do: doc.id
  def field(doc, :rev), do: doc.rev
  def field(doc, :raw_doc), do: Jason.encode!(doc.attrs)
  def field(doc, fieldname), do: doc.attrs[Atom.to_string(fieldname)]
end
