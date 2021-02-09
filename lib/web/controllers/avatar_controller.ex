defmodule Web.AvatarController do
  use Web, :controller

  alias Web.Models.Avatar

  def show(conn, %{"seed" => seed}) do
    avatar = Avatar.build(seed)
    send_file(conn, 200, avatar)
  end
end
