defmodule CrawlerChallenge.DetailsFactory do
  use ExMachina.Ecto, repo: CrawlerChallenge.Repo
  alias Faker.{Lorem, Name}

  defmacro __using__(_opts) do
    quote do
      def details_factory do
        %CrawlerChallenge.Details.Detail{
          process_number: "0000575-40.2014.8.02.0081",
          class: Lorem.words(),
          costs: Lorem.words(),
          control: Lorem.words(),
          area: Lorem.word(),
          subject: Lorem.sentence(),
          other_subject: Lorem.words(),
          other_numbers: Lorem.words(),
          distribution_data: "14/10/2019",
          judge: Name.name(),
          stock_price: "1.100,00",
          process: build(:process)
        }
      end
    end
  end
end
