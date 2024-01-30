# Cozy-Toolbox

## What is Cozy?

![Cozy Logo](https://cdn.rawgit.com/cozy/cozy-guidelines/master/templates/cozy_logo_small.svg)

[Cozy](https://cozy.io) is a platform that brings all your web services in the
same private space. With it, your web apps and your devices can share data
easily, providing you with a new experience. You can install Cozy on your own
hardware where no one profiles you.

## Cozy-Toolbox

Cozy-Toolbox is a web application that can be used to manage instances and
develop in local. It is a mix of the cloudery, bender, fauxton and other apps.
It can be used to browse the data in CouchDB, create local instances, or run
a fake OIDC server.

## How to start?

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:5000`](http://localhost:5000) from your browser.

If you need to configure the CouchDB to use, you can use the `TOOLBOX_DB_AUTH`
and `TOOLBOX_DB_URL` env variables:

```
$ TOOLBOX_DB_AUTH=user:p4ssw0rd TOOLBOX_DB_URL=http://couch:5984 iex -S mix phx.server
```

It's also possible to create your own environment:

```
$ cp config/prod.exs config/my_prod.exs && $EDITOR config/my_prod.exs && MIX_ENV=my_prod iex -S mix phx.server
```

## Community

You can reach the Cozy Community by:

* Chatting with us on IRC #cozycloud on [Libera.Chat](https://web.libera.chat/#cozycloud)
* Posting on our [Forum](https://forum.cozy.io)
* Posting issues on the [Github repos](https://github.com/cozy/)
* Mentioning us on [Twitter](https://twitter.com/cozycloud)

## License

Cozy is developed by Cozy Cloud and distributed under the AGPL v3 license.

## Credits

The wallpaper for the home is a photo taken by Boris Renner, licensed as
CC-by-sa 3.0. See
https://commons.wikimedia.org/wiki/File:Lampovna_narodni_kulturni_pamatky_dolu_michal_2008.jpg
for more details.
