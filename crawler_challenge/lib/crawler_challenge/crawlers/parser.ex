defmodule CrawlerChallenge.Parser do
  def parse(body) do
    Floki.parse(body)
  end
end
