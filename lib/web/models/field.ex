defmodule Web.Models.Field do
  @moduledoc false

  def list("io.cozy.apps"), do: [slug: "link", rev: "", version: "", raw_doc: "ellipsis"]
  def list("io.cozy.contacts"), do: [id: "link", rev: "", displayName: "", raw_doc: "ellipsis"]
  def list("io.cozy.contacts.groups"), do: [id: "link", rev: "", name: "", raw_doc: "ellipsis"]

  def list("io.cozy.files"),
    do: [icon_file: "icon", id: "link", rev: "", name: "", raw_doc: "ellipsis"]

  def list("io.cozy.jobs"),
    do: [id: "link", rev: "", worker: "", state: "", raw_doc: "ellipsis"]

  def list("io.cozy.konnectors"), do: [slug: "link", rev: "", version: "", raw_doc: "ellipsis"]

  def list("io.cozy.oauth.clients"),
    do: [id: "link", rev: "", client_name: "", raw_doc: "ellipsis"]

  def list("io.cozy.permissions"),
    do: [id: "link", rev: "", type: "", source_id: "", raw_doc: "ellipsis"]

  def list("io.cozy.photos.albums"), do: [id: "link", rev: "", name: "", raw_doc: "ellipsis"]

  def list("io.cozy.sharings"),
    do: [
      id: "link",
      rev: "",
      description: "",
      app_slug: "",
      owner: "",
      active: "",
      raw_doc: "ellipsis"
    ]

  def list("io.cozy.triggers"),
    do: [id: "link", rev: "", worker: "", type: "", arguments: "ellipsis", raw_doc: "ellipsis"]

  def list(_doctypename), do: [id: "link", rev: "", raw_doc: "ellipsis"]

  def get(doc, :icon_file) do
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

  def get(doc, :id), do: doc.id
  def get(doc, :rev), do: doc.rev
  def get(doc, :raw_doc), do: Jason.encode!(doc.attrs)
  def get(doc, fieldname), do: doc.attrs[Atom.to_string(fieldname)]
end
