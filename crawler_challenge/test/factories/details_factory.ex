defmodule CrawlerChallenge.DetailsFactory do
  use ExMachina.Ecto, repo: CrawlerChallenge.Repo
  alias Faker.{Lorem, Name}

  defmacro __using__(_opts) do
    quote do
      def details_factory do
        %CrawlerChallenge.Details.Detail{
          process_number: "0000575-40.2014.8.02.0081",
          class: Name.name(),
          costs: Name.name(),
          control: Name.name(),
          area: Name.name(),
          subject: Name.name(),
          other_subject: Name.name(),
          other_numbers: Name.name(),
          distribution_date: "14/10/2019",
          judge: Name.name(),
          stock_price: "1.100,00",
          process: build(:process)
        }
      end
    end
  end
end
