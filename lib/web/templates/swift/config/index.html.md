# Fake Swift server

The stack can use Swift for storing files. It can be tedious to install a Swift
server for local development. Even [Swift all in
one](https://docs.openstack.org/swift/latest/development_saio.html) can take
several hours and has some limitations. As an alternative, we offer a fake Swift
server that tries to be compatible with the Swift API for the operations used by
the stack. It doesn't cover the full API obviously, and even for the supported
operations, we can have differences in behavior. For example, we don't try to
emulate the complex behavior that can arise from eventual consistency. So, it's
a good tool for development in local, but you should test with a real Swift
environment too.

## Config

```yaml
fs:
  url: swift://openstack/?UserName=admin&Password=p4ssw0rd&ProjectName=stack&UserDomainName=default&EndpointType=internal
  default_layout: 2
```

* `UserDomainName`: user's domain name, `default`
* `UserName`: there is a single account, `admin`
* `Password`: whatever you want, the fake Swift server doesn't check it
* `ProjectName`: the tenant you want to use
* `EndpointType`: `public`, `internal`, or `admin`
