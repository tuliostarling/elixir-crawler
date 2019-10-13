defmodule CrawlerChallenge.MovementsFactory do
  use ExMachina.Ecto, repo: CrawlerChallenge.Repo
  alias Faker.Lorem

  defmacro __using__(_opts) do
    quote do
      def movements_factory do
        %CrawlerChallenge.Movements.Movement{
          movement: Lorem.sentence(),
          movement_date: "14/10/2019",
          process: build(:process)
        }
      end
    end
  end
end
