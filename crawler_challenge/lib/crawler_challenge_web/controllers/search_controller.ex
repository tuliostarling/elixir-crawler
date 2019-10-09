defmodule CrawlerChallengeWeb.SearchController do
  use CrawlerChallengeWeb, :controller

  alias CrawlerChallenge.{Parser, Scraper, Searches}

  def index(conn, %{"court" => _court, "process_n" => process_n}) do
    {:ok, url} =
      process_n
      |> String.slice(0, 15)
      |> Searches.mount_search_url(process_n)
      |> Searches.return_location()

    {:ok, body} = Searches.get_html_body(url)

    result =
      body
      |> Parser.parse()
      |> Scraper.scrapy()

    conn
  end
end
