defmodule CrawlerChallenge.ProcessFactory do
  use ExMachina.Ecto, repo: CrawlerChallenge.Repo

  use Timex

  defmacro __using__(_opts) do
    quote do
      def process_factory do
        %CrawlerChallenge.Processes.Process{
          process_number: "0725703-91.2019.8.02.0001",
          court: build(:courts)
        }
      end

      def another_process_factory do
        %CrawlerChallenge.Processes.Process{
          process_number: "0000575-40.2014.8.02.0081",
          court: build(:courts),
          inserted_at: Timex.shift(Timex.now(), hours: 1)
        }
      end
    end
  end
end
