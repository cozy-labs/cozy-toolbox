defmodule Web.OidcController do
  use Web, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  # https://openid.net/specs/openid-connect-core-1_0.html#AuthorizationEndpoint
  def authorize(conn, params) do
    render(conn, "authorize.html", params: params)
  end

  # https://openid.net/specs/openid-connect-core-1_0.html#AuthResponse
  def authorized(conn, params) do
    location =
      "#{params["redirect_uri"]}?code=#{params["code"]}&state=#{params["state"]}&nonce=#{
        params["nonce"]
      }"

    redirect(conn, external: location)
  end

  # https://openid.net/specs/openid-connect-core-1_0.html#TokenRequest
  def token(conn, _params) do
    token = "isabell-token"
    json(conn, %{access_token: token, token_type: "Bearer"})
  end

  # https://openid.net/specs/openid-connect-core-1_0.html#UserInfoRequest
  def userinfo(conn, _params) do
    my_cloud_url = "cozy.localhost:8080"
    json(conn, %{sub: 123, myCloudUrl: my_cloud_url})
  end
end
