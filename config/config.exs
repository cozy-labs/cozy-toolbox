# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :tools, Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "W2c5erb5aWNhFth1SuiHY/H3mZ2/dPKw+kMbUwRpbiUS/KSwBJ8WSMvyuvojy6UW",
  render_errors: [view: Web.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Tools.PubSub,
  live_view: [signing_salt: "SCwMbZzo"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :phoenix, :template_engines, md: PhoenixMarkdown.Engine

config :phoenix_markdown, :earmark, %{code_class_prefix: "language-"}

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
