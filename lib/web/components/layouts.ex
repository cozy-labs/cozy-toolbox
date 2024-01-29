defmodule Web.Layouts do
  use Web, :html

  embed_templates "layouts/*"

  def view(conn) do
    conn
    |> Phoenix.Controller.view_module()
    |> Phoenix.Template.module_to_template_root(Web, "View")
    |> String.replace_suffix("_html", "")
  end
end
