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
alias CrawlerChallenge.{Courts.Court, Repo, Processes.Process}

Repo.insert(%Court{
  name: "Tribunal de Justiça do Alagoas",
  initials: "TJAL"
})

Repo.insert(%Process{
  process_number: "1008126-92.2015.8.26.0132",
  court_id: 1
})
