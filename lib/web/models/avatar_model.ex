defmodule Web.Models.Avatar do
  @moduledoc false

  def build(seed) do
    params = compute_params(seed)
    filename = get_filename(params)
    unless File.exists?(filename), do: build_avatar(filename, params)
    filename
  end

  defp compute_params(seed) do
    <<i1::unsigned-integer-32, i2::unsigned-integer-32, i3::unsigned-integer-32, _::binary>> =
      :erlang.md5(seed)

    :rand.seed(:exrop, {i1, i2, i3})

    [
      tail: Enum.random(1..9),
      hoop: Enum.random(1..10),
      body: Enum.random(1..9),
      wing: Enum.random(1..9),
      eyes: Enum.random(1..9),
      bec: Enum.random(1..9),
      accessorie: Enum.random(1..20)
    ]
  end

  defp get_filename(params) do
    dir = Application.get_env(:toolbox, __MODULE__)[:cache_dir]
    base = params |> Keyword.values() |> Enum.join("-")
    Path.join(dir, "#{base}.png")
  end

  defp build_avatar(filename, params) do
    File.mkdir_p(Path.dirname(filename))
    args = Enum.map(params, fn {k, v} -> "assets/avatars/bird/#{k}_#{v}.png" end)
    System.cmd("convert", args ++ ["-flatten", filename])
  end
end
