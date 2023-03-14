# Fake FranceConnect server

Cozy-toolbox can be used to test delegated authentication with a local
cozy-stack by providing a fake FranceConnect server.

## Stack configuration

```yaml
authentication:
  cerfs:
    franceconnect:
      client_id: "211286433e39cce01db448d80181bdfd005554b19cd51b3fe7943f6b3b86ab6e"
      client_secret: "2791a731e6a59f56b6b4dd0d08c9b1f593b5f3658b9fd731cb24248e2669af4b"
      scope: openid profile
      redirect_uri: http://oauthcallback.localhost:8080/oidc/redirect
      authorize_url: http://localhost:5000/api/v1/authorize
      token_url: http://localhost:5000/api/v1/token
      userinfo_url: http://localhost:5000/api/v1/userinfo
```

## Cloudery configuration

```yaml
config:
  franceconnect:
    scope: [ openid, email ]
    client_id: "211286433e39cce01db448d80181bdfd005554b19cd51b3fe7943f6b3b86ab6e"
    client_secret: "2791a731e6a59f56b6b4dd0d08c9b1f593b5f3658b9fd731cb24248e2669af4b"
    authorize_url: http://localhost:5000/api/v1/authorize
    token_url: http://localhost:5000/api/v1/token
    userinfo_url: http://localhost:5000/api/v1/userinfo
```
