defmodule CrawlerChallengeWeb.SearchController do
  use CrawlerChallengeWeb, :controller

  alias CrawlerChallenge.Search

  def index(conn, %{"court" => court, "process_n" => process_n} = params) do
    {:ok, url} =
      process_n
      |> String.slice(0, 15)
      |> Search.mount_search_url(process_n)
      |> Search.return_location()

    {:ok, body} = Search.get_html_body(url)
  end
end
