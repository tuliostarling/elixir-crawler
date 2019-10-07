use Mix.Config

# Configure your database
config :crawler_challenge, CrawlerChallenge.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "tuliostarling",
  password: "85295198",
  database: "crawler_challenge_dev",
  hostname: "localhost",
  pool_size: 10
