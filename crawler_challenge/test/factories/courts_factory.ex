defmodule CrawlerChallenge.CourtsFactory do
  use ExMachina.Ecto, repo: CrawlerChallenge.Repo

  alias Faker.{Lorem, Name}

  defmacro __using__(_opts) do
    quote do
      def courts_factory do
        %CrawlerChallenge.Courts.Court{
          name: Name.first_name(),
          initials: Lorem.characters(2..4)
        }
      end
    end
  end
end
