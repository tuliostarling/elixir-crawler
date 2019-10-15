defmodule CrawlerChallenge.CourtsFactory do
  use ExMachina.Ecto, repo: CrawlerChallenge.Repo

  alias Faker.Name

  defmacro __using__(_opts) do
    quote do
      def courts_factory do
        %CrawlerChallenge.Courts.Court{
          name: Name.first_name(),
          initials: Name.name()
        }
      end
    end
  end
end
