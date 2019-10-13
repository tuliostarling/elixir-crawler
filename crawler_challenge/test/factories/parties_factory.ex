defmodule CrawlerChallenge.PartiesFactory do
  use ExMachina.Ecto, repo: CrawlerChallenge.Repo
  alias Faker.Name

  defmacro __using__(_opts) do
    quote do
      def parties_factory do
        %CrawlerChallenge.Parties.Partie{
          partie: Name.title(),
          name: Name.name(),
          position: Name.title(),
          person_name_position: Name.name(),
          process: build(:process)
        }
      end
    end
  end
end
