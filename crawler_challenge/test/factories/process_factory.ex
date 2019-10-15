defmodule CrawlerChallenge.ProcessFactory do
  use ExMachina.Ecto, repo: CrawlerChallenge.Repo

  use Timex

  defmacro __using__(_opts) do
    quote do
      def process_factory do
        %CrawlerChallenge.Processes.Process{
          process_number: "0000575-40.2014.8.02.0081",
          court: build(:courts)
        }
      end

      def valid_process_factory do
        %CrawlerChallenge.Processes.Process{
          process_number: "0000575-40.2014.8.02.0081",
          court: build(:courts),
          inserted_at: Timex.shift(Timex.now(), hours: 1)
        }
      end

      def invalid_process_factory do
        %CrawlerChallenge.Processes.Process{
          process_number: "0000575-40.2014.8.02.0081",
          court: build(:courts),
          inserted_at: Timex.shift(Timex.now(), hours: -25)
        }
      end
    end
  end
end
