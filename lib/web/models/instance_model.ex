defmodule Web.Models.Instance do
  @moduledoc false

  alias Web.Models.Couch
  alias Web.Models.Instance

  defstruct [:id, :domain]

  def list(couch) do
    couch
    |> Couch.list("global/instances")
    |> Enum.map(fn x -> Instance.from_params(x) end)
  end

  def from_params(params) do
    %Instance{id: params["_id"], domain: params["domain"]}
  end
end
