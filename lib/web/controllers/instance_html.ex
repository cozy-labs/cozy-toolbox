defmodule Web.InstanceHTML do
  use Web, :html

  alias Web.Models.Couch

  embed_templates "instance_html/*"
end
