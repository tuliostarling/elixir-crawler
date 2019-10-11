# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     CrawlerChallenge.Repo.insert!(%CrawlerChallenge.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias CrawlerChallenge.{Courts.Court, Repo}

Repo.insert(%Court{
  name: "Tribunal de Justiça do Alagoas",
  initials: "TJAL"
})
