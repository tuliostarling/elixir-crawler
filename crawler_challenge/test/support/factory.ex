defmodule CrawlerChallenge.Factory do
  use ExMachina.Ecto, repo: CrawlerChallenge.Repo

  use CrawlerChallenge.{
    DetailsFactory,
    CourtsFactory,
    MovementsFactory,
    PartiesFactory,
    ProcessFactory
  }
end
