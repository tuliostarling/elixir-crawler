defmodule CrawlerChallengeWeb.SearchController do
  use CrawlerChallengeWeb, :controller

  alias CrawlerChallenge.Searches

  def index(conn, %{"court" => _court, "process_n" => process_n}) do
    search_url =
      process_n
      |> String.slice(0, 15)
      |> Searches.mount_search_url(process_n)

    with {:ok, show_url} <- Searches.return_show_url(search_url),
         {:ok, body} <- Searches.get_html_body(show_url),
         {:ok, []} <- Searches.get_value_from_scraper_and_insert(body) do
      conn
    else
      {:error, reason} ->
        {:error, reason}
    end
  end
end
