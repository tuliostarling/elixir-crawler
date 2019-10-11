defmodule CrawlerChallengeWeb.SearchController do
  use CrawlerChallengeWeb, :controller

  alias CrawlerChallenge.{Details, Movements, Parties, Processes, Repo, Searches}

  def index(conn, %{"court" => court, "process_n" => process_n}) do
    search_url =
      process_n
      |> String.slice(0, 15)
      |> Searches.mount_search_url(process_n)

    with {:ok, show_url} <- Searches.return_show_url(search_url),
         {:ok, body} <- Searches.get_html_body(show_url),
         {:ok, crawled_data} <- Searches.get_crawled_data(body),
         {:ok, _result} <- insert_all_data(process_n, court, crawled_data) do
      
    else
      {:error, reason} ->
        {:error, reason}
    end
  end

  def insert_all_data(process, court, crawled_data) do
    process
    |> Processes.insert_process_by_multi(court)
    |> Movements.insert_movement_by_multi(crawled_data[:list_movements])
    |> Parties.insert_parties_by_multi(crawled_data[:list_parties])
    |> Details.insert_details_by_multi(crawled_data[:list_details])
    |> Repo.transaction()
    |> case do
      {:ok, result} -> {:ok, result}
      {:error, reason} -> {:error, reason}
    end
  end
end
