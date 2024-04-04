import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :toolbox, Web.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 5902],
  secret_key_base: "4J2VrpZSEt4LKurM//MBsI23QGxlK1QNaPvelv1IOeXWsU7ZIUPaOEAhGcFNB7wB",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
