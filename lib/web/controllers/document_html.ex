defmodule Web.DocumentHTML do
  use Web, :html

  alias Web.Models.Couch

  embed_templates "document_html/*"
end
