defmodule Web.Swift.IdentityController do
  use Web, :controller

  # https://docs.openstack.org/keystone/ocata/devref/api_curl_examples.html
  def tokens(conn, %{
        "auth" => %{"identity" => %{"password" => %{"user" => %{"name" => "admin"}}}}
      }) do
    now = NaiveDateTime.utc_now()

    body = %{
      token: %{
        # valid for 10 minutes
        expires_at: NaiveDateTime.add(now, 600),
        issued_at: now,
        catalog: [
          %{
            endpoints: [
              %{
                url: "#{Routes.page_url(conn, :index)}v1/AUTH_tester",
                region: "RegionOne",
                interface: "internal",
                id: "8707e3735d4415c97ae231b4841eb1c"
              }
            ],
            type: "object-store",
            id: "bd73972c0e14fb69bae8ff76e112a90",
            name: "swift"
          }
        ]
      }
    }

    json(conn, body)
  end

  def tokens(conn, _params) do
    conn
    |> put_status(401)
    |> json(%{error: "Not authorized"})
  end
end
