# Fake OIDC server

Cozy-toolbox can be used to test delegated authentication with a local
cozy-stack by providing a fake OIDC server. Several configurations are
possible:

## Cerfs

```yaml
authentication:
  cerfs:
    disable_password_authentication: true
    oidc:
      client_id: myBelenosClientID
      client_secret: myBelenosSecret
      scope: openid profile
      redirect_uri: http://oauthcallback.cozy.tools:8080/oidc/redirect
      authorize_url: http://cozy.tools:5000/oidc/cerfs/authorize
      token_url: http://cozy.tools:5000/oidc/cerfs/token
      userinfo_url: http://cozy.tools:5000/oidc/cerfs/userinfo
      userinfo_instance_field: myCloudUrl
```

## TODO

* Improve the look of the OIDC pages
* Make it possible to have other backends and add the _faim_ backend
* Allow to have several users per backend
  * List the instances (`cozy-stack instances ls`) for the given context
* Add validation on parameters
  * Check mandatory parameters
  * Be more helpful on errors
* Improve the code for building the redirect location on POST /authorize
* Allow to simulate errors
