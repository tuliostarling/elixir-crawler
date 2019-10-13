defmodule CrawlerChallenge.ProcessFactory do
  use ExMachina.Ecto, repo: CrawlerChallenge.Repo

  defmacro __using__(_opts) do
    quote do
      def process_factory do
        %CrawlerChallenge.Process.Proces{
          process_number: "0000575-40.2014.8.02.0081",
          court: build(:court)
        }
      end
    end
  end
end
