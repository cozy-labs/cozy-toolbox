defmodule ToolsWeb.LayoutView do
  use ToolsWeb, :view

  def view(conn) do
    conn
    |> Phoenix.Controller.view_module()
    |> Phoenix.Template.module_to_template_root(ToolsWeb, "View")
  end
end
