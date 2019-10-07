defmodule CrawlerChallenge.Repo do
  use Ecto.Repo,
    otp_app: :crawler_challenge,
    adapter: Ecto.Adapters.Postgres
end
