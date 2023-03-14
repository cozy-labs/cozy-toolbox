defmodule Web.OidcController do
  use Web, :controller

  alias Web.Models.Couch
  alias Web.Models.Instance

  def index(conn, _params) do
    render(conn, "index.html")
  end

  # https://openid.net/specs/openid-connect-core-1_0.html#AuthorizationEndpoint
  def authorize(conn, params) do
    logins =
      Couch.default()
      |> Instance.list()
      |> Enum.map(fn instance ->
        instance.domain |> String.split(".") |> Enum.at(0)
      end)
      |> Enum.concat(["emma", "jane", "kevin", "laurent", "manon"])
      |> Enum.sort()
      |> Enum.uniq()

    render(conn, "authorize.html", %{params: params, logins: logins})
  end

  # https://openid.net/specs/openid-connect-core-1_0.html#AuthResponse
  def authorized(conn, %{
        "redirect_uri" => redirect,
        "code" => code,
        "state" => state,
        "nonce" => nonce
      }) do
    location = "#{redirect}?code=#{code}&state=#{state}&nonce=#{nonce}"
    redirect(conn, external: location)
  end

  # https://openid.net/specs/openid-connect-core-1_0.html#TokenRequest
  def token(conn, %{"code" => code}) do
    token = "#{code}-token"
    json(conn, %{access_token: token, token_type: "Bearer"})
  end

  # https://openid.net/specs/openid-connect-core-1_0.html#UserInfoRequest
  def userinfo(conn, _params) do
    login =
      Plug.Conn.get_req_header(conn, "authorization")
      |> Enum.at(0)
      |> String.trim_leading("Bearer ")
      |> String.trim_trailing("-token")

    json(conn, %{
      sub: login,
      myCloudUrl: "#{login}.localhost:8080",
      email: "#{login}@spam.cozycloud.cc"
    })
  end
end
