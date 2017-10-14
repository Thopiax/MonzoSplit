# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :monzo_split,
  ecto_repos: [MonzoSplit.Repo],
  monzo_client_id: "${MONZO_CLIENT_ID}",
  monzo_client_secret: "${MONZO_CLIENT_SECRET}")

# Configures the endpoint
config :monzo_split, MonzoSplitWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "/dePW2eMs0lLYb+eoDxlcWLeGuvUCeG1m5HdmEyshEPfIs6AqcRlJ2aGTi2PwNsF",
  render_errors: [view: MonzoSplitWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: MonzoSplit.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :template_engines,
  drab: Drab.Live.Engine

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
