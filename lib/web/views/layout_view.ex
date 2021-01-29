defmodule Web.LayoutView do
  use Web, :view

  def view(conn) do
    conn
    |> Phoenix.Controller.view_module()
    |> Phoenix.Template.module_to_template_root(Web, "View")
  end
end
