defmodule Web.Models.Couch do
  @moduledoc false

  alias Web.Models.Couch

  defstruct [:url]

  def default, do: %Couch{url: "http://localhost:5984"}

  def list(%Couch{url: url}, db) do
    [
      %{"id" => "1", "domain" => "alice.cozy.tools:8080"},
      %{"id" => "2", "domain" => "bob.cozy.tools:8080"}
    ]
  end
end
