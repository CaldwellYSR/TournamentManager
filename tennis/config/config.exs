# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :tennis,
  ecto_repos: [Tennis.Repo]

# Configures the endpoint
config :tennis, TennisWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "xGiZaFNfnQQHTJ8GeeAhWeein8KJJkj1eXWYOIv2tjbj1ZBBGOTI0yVDy69eIdgr",
  render_errors: [view: TennisWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Tennis.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
