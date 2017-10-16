# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :monzo_split,
  ecto_repos: [MonzoSplit.Repo],
  monzo: %{
    client_id: System.get_env("MONZO_CLIENT_ID") || "${MONZO_CLIENT_ID}",
    client_secret: System.get_env("MONZO_CLIENT_SECRET") || "${MONZO_CLIENT_SECRET}",
    website: "https://api.monzo.com",
    authorize_url: "https://auth.getmondo.co.uk",
    token_url: "https://api.monzo.com/oauth2/token",
    redirect_uri: "https://naive-tepid-koalabear.gigalixirapp.com/api/monzo/oauth/complete"
  },
  splitwise: %{
    client_id: System.get_env("SPLITWISE_CLIENT_ID") || "${SPLITWISE_CLIENT_ID}",
    client_secret: System.get_env("SPLITWISE_CLIENT_SECRET") || "${SPLITWISE_CLIENT_SECRET}",
    website: "https://secure.splitwise.com",
    authorize_url: "https://secure.splitwise.com/oauth/authorize",
    token_url: "https://secure.splitwise.com/oauth/token",
    redirect_uri: "https://naive-tepid-koalabear.gigalixirapp.com/api/splitwise/oauth/complete"
  }

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

config :oauth2, debug: true


# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
